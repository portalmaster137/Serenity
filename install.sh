#!/usr/bin/env bash
set -euo pipefail

# ============================================
# SerenityOS NixOS Interactive Installer
# ============================================
# Supports: Ext4/ZFS, LUKS encryption, AMD/NVIDIA GPUs
# Usage: sudo ./install.sh
# ============================================

# Source default configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/install.conf"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# ============================================
# Helper functions
# ============================================

log() { echo -e "${GREEN}[*]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
error() { echo -e "${RED}[x]${NC} $1"; exit 1; }
info() { echo -e "${BLUE}[i]${NC} $1"; }
step() { echo -e "\n${CYAN}${BOLD}=== $1 ===${NC}\n"; }

prompt() {
    local prompt_text="$1"
    local default="$2"
    local result
    read -rp "$(echo -e "${BOLD}$prompt_text${NC} [${default}]: ")" result
    echo "${result:-$default}"
}

prompt_password() {
    local prompt_text="$1"
    local result
    read -rsp "$(echo -e "${BOLD}$prompt_text${NC}: ")" result
    echo ""
    echo "$result"
}

prompt_yn() {
    local prompt_text="$1"
    local default="${2:-y}"
    local result
    read -rp "$(echo -e "${BOLD}$prompt_text${NC} [${default}]: ")" result
    result="${result:-$default}"
    [[ "$result" =~ ^[Yy]$ ]]
}

prompt_choice() {
    local prompt_text="$1"
    shift
    local options=("$@")
    local choice

    echo -e "${BOLD}$prompt_text${NC}"
    for i in "${!options[@]}"; do
        echo "  $((i+1))) ${options[$i]}"
    done

    while true; do
        read -rp "$(echo -e "${BOLD}Select [1-${#options[@]}]: ${NC}")" choice
        if [[ "$choice" =~ ^[0-9]+$ ]] && \
           (( choice >= 1 && choice <= ${#options[@]} )); then
            echo "${options[$((choice-1))]}"
            return
        fi
        warn "Invalid selection. Please try again."
    done
}

# ============================================
# 1. Welcome & Environment Check
# ============================================

step "Welcome to SerenityOS Installer"

echo -e "${CYAN}"
printf '%s\n' \
  "███████╗███████╗██████╗ ███████╗███╗   ██╗██╗████████╗██╗   ██╗" \
  "██╔════╝██╔════╝██╔══██╗██╔════╝████╗  ██║╚══██╔══╝╚██╗ ██╔╝" \
  "███████╗█████╗  ██████╔╝█████╗  ██╔██╗ ██║   ██║    ╚████╔╝ " \
  "╚════██║██╔══╝  ██╔══██╗██╔══╝  ██║╚██╗██║   ██║     ╚██╔╝  " \
  "███████║███████╗██║  ██║███████╗██║ ╚████║   ██║      ██║   " \
  "╚══════╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝      ╚═╝   "
echo -e "${NC}"

log "Verifying installation environment..."

# Check we're running as root
if [[ $EUID -ne 0 ]]; then
    error "This script must be run as root (use sudo or boot as root)"
fi

# Check we're in the NixOS installer
if [[ ! -f /etc/nixos/configuration.nix ]]; then
    error "This script must be run from the NixOS minimal installer"
fi

# Check network connectivity
log "Checking network connectivity..."
if ! ping -c 1 -W 5 1.1.1.1 &>/dev/null; then
    warn "No network connection detected."
    if ! prompt_yn "Continue anyway?" "n"; then
        error "Please configure networking and try again."
    fi
fi

# Check git is available
if ! command -v git &>/dev/null; then
    warn "git not found, installing..."
    nix-env -iA nixpkgs.git
fi

log "Environment verified."

# ============================================
# 2. Detect Hardware
# ============================================

step "Hardware Detection"

# Detect CPU
CPU_VENDOR=$(grep -m1 'vendor_id' /proc/cpuinfo | awk '{print $3}')
info "CPU Vendor: $CPU_VENDOR"

# Detect GPU
GPU_INFO=$(lspci -nn | grep -i 'vga\|3d\|display' || true)
info "Detected GPUs:"
echo "$GPU_INFO" | while read -r line; do
    echo "  $line"
done

# Detect NVIDIA GPU
NVIDIA_GPU=false
if echo "$GPU_INFO" | grep -qi "nvidia"; then
    NVIDIA_GPU=true
    info "NVIDIA GPU detected"
fi

# Detect AMD GPU
AMD_GPU=false
if echo "$GPU_INFO" | grep -qi "amd\|ati"; then
    AMD_GPU=true
    info "AMD GPU detected"
fi

# Detect Intel GPU
INTEL_GPU=false
if echo "$GPU_INFO" | grep -qi "intel"; then
    INTEL_GPU=true
    info "Intel GPU detected"
fi

# Detect if running in VM
IS_VM=false
if systemd-detect-virt &>/dev/null && [[ "$(systemd-detect-virt)" != "none" ]]; then
    IS_VM=true
    info "Running in a VM: $(systemd-detect-virt)"
fi

# ============================================
# 3. Configure Installation
# ============================================

step "Installation Configuration"

# Select host configuration
HOST=$(prompt_choice "Select host configuration:" "usb" "hades" "template")
info "Selected host: $HOST"

# Select disk
echo ""
log "Available disks:"
lsblk -d -o NAME,SIZE,MODEL,TRAN | grep -v "loop\|rom"
echo ""

while true; do
    DISK=$(prompt "Enter disk to install to" "$DISK")
    if [[ -b "$DISK" ]]; then
        break
    fi
    warn "Disk $DISK does not exist. Please try again."
done

# Show disk info
info "Selected disk: $DISK"
lsblk "$DISK" -o NAME,SIZE,FSTYPE,MOUNTPOINT
echo ""

# Confirm disk selection
if ! prompt_yn "WARNING: This will DESTROY all data on $DISK. Continue?" "n"; then
    error "Installation cancelled."
fi

# Select filesystem
FILESYSTEM=$(prompt_choice "Select filesystem:" "ext4" "zfs")
info "Selected filesystem: $FILESYSTEM"

# Encryption
ENCRYPT=false
if [[ "$FILESYSTEM" == "zfs" ]]; then
    if prompt_yn "Enable ZFS native encryption?" "y"; then
        ENCRYPT=true
    fi
else
    if prompt_yn "Enable LUKS encryption?" "y"; then
        ENCRYPT=true
    fi
fi

# Hostname
HOSTNAME=$(prompt "Enter hostname" "$HOSTNAME")
info "Hostname: $HOSTNAME"

# Username
USERNAME=$(prompt "Enter username" "$USERNAME")
info "Username: $USERNAME"

# Password
echo ""
PASSWORD=$(prompt_password "Enter password for $USERNAME")
if [[ -z "$PASSWORD" ]]; then
    error "Password cannot be empty"
fi
PASSWORD_CONFIRM=$(prompt_password "Confirm password")
if [[ "$PASSWORD" != "$PASSWORD_CONFIRM" ]]; then
    error "Passwords do not match"
fi

# Git configuration
echo ""
GIT_USER=$(prompt "Git username" "$GIT_USER")
GIT_EMAIL=$(prompt "Git email" "$GIT_EMAIL")

# Locale and timezone
echo ""
LOCALE=$(prompt "Locale" "$LOCALE")
TIMEZONE=$(prompt "Timezone" "$TIMEZONE")

# GPU configuration
echo ""
if [[ "$NVIDIA_GPU" == true ]]; then
    if prompt_yn "Enable NVIDIA GPU support?" "y"; then
        ENABLE_NVIDIA=true
    else
        ENABLE_NVIDIA=false
    fi
fi

if [[ "$AMD_GPU" == true ]]; then
    if prompt_yn "Enable AMD GPU support?" "y"; then
        ENABLE_AMD=true
    else
        ENABLE_AMD=false
    fi
fi

# Feature selection (for desktop installs)
if [[ "$HOST" != "usb" ]]; then
    echo ""
    step "Feature Selection"

    ENABLE_GAMING=false
    ENABLE_MEDIA_SERVER=false
    ENABLE_VR=false
    ENABLE_MUSIC=false
    ENABLE_BLUETOOTH=false

    if prompt_yn "Enable gaming (Steam, Lutris, etc.)?" "y"; then
        ENABLE_GAMING=true
    fi

    if prompt_yn "Enable media server (Jellyfin, etc.)?" "n"; then
        ENABLE_MEDIA_SERVER=true
    fi

    if prompt_yn "Enable VR support?" "n"; then
        ENABLE_VR=true
    fi

    if prompt_yn "Enable music production (DAW, etc.)?" "n"; then
        ENABLE_MUSIC=true
    fi

    if prompt_yn "Enable Bluetooth?" "y"; then
        ENABLE_BLUETOOTH=true
    fi
fi

# ============================================
# 4. Partition and Format Disk
# ============================================

step "Partitioning Disk"

log "Wiping disk $DISK..."
wipefs -af "$DISK"
sgdisk --zap-all "$DISK" 2>/dev/null || true

if [[ "$FILESYSTEM" == "zfs" ]]; then
    log "Creating ZFS partitions..."

    # ZFS partitioning: 1GiB boot, rest for ZFS
    parted -s "$DISK" -- \
        mklabel gpt \
        mkpart ESP fat32 1MiB 1GiB \
        set 1 esp on \
        mkpart primary 1GiB 100%

    # Wait for partition table to sync
    sleep 2
    partprobe "$DISK" 2>/dev/null || true
    sleep 1

    # Format boot partition
    mkfs.fat -F32 -n boot "${DISK}1"

    # Create ZFS pool
    if [[ "$ENCRYPT" == true ]]; then
        # ZFS native encryption
        zpool create -f \
            -o ashift=12 \
            -O compression=zstd \
            -O xattr=sa \
            -O acltype=posixacl \
            -O encryption=aes-256-gcm \
            -O keyformat=passphrase \
            -O mountpoint=none \
            rpool "${DISK}2"
    else
        # No encryption
        zpool create -f \
            -o ashift=12 \
            -O compression=zstd \
            -O xattr=sa \
            -O acltype=posixacl \
            -O mountpoint=none \
            rpool "${DISK}2"
    fi

    # Create ZFS datasets
    zfs create -o mountpoint=legacy rpool/root
    zfs create -o mountpoint=legacy rpool/home
    zfs create -o mountpoint=legacy rpool/nix

    # Mount filesystems
    mount -t zfs rpool/root /mnt
    mkdir -p /mnt/home /mnt/nix /mnt/boot
    mount -t zfs rpool/home /mnt/home
    mount -t zfs rpool/nix /mnt/nix
    mount /dev/disk/by-label/boot /mnt/boot

    # Generate hostId for ZFS
    HOSTID=$(head -c 8 /dev/urandom | od -An -tx1 | tr -d ' \n')
    info "Generated hostId: $HOSTID"

else
    log "Creating Ext4 partitions..."

    # Ext4 partitioning: 1GiB boot, 8GiB swap, rest for root
    parted -s "$DISK" -- \
        mklabel gpt \
        mkpart ESP fat32 1MiB 1GiB \
        set 1 esp on \
        mkpart primary linux-swap 1GiB 9GiB \
        mkpart primary 9GiB 100%

    # Wait for partition table to sync
    sleep 2
    partprobe "$DISK" 2>/dev/null || true
    sleep 1

    # Format boot partition
    mkfs.fat -F32 -n boot "${DISK}1"

    if [[ "$ENCRYPT" == true ]]; then
        # LUKS encryption
        log "Setting up LUKS encryption..."
        echo -n "$PASSWORD" | cryptsetup luksFormat --type luks2 "${DISK}3" -
        echo -n "$PASSWORD" | cryptsetup open "${DISK}3" luks-root -

        mkfs.ext4 -L nixos /dev/mapper/luks-root
        mount /dev/mapper/luks-root /mnt
    else
        # No encryption
        mkfs.ext4 -L nixos "${DISK}3"
        mount /dev/disk/by-label/nixos /mnt
    fi

    # Setup swap
    mkswap -L swap "${DISK}2"
    swapon "${DISK}2"

    # Mount boot
    mkdir -p /mnt/boot
    mount /dev/disk/by-label/boot /mnt/boot
fi

log "Disk partitioned and formatted successfully."

# ============================================
# 5. Clone & Configure Repository
# ============================================

step "Setting Up Configuration"

# Enable flakes
log "Enabling Nix flakes..."
mkdir -p /etc/nix
echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf

# Clone the repository
if [[ -d /mnt/etc/nixos/.git ]]; then
    log "Repository already exists, pulling latest..."
    cd /mnt/etc/nixos
    git pull
else
    log "Cloning SerenityOS configuration..."
    git clone https://codeberg.org/Serenity-F/SerenityOS /mnt/etc/nixos
fi

cd /mnt/etc/nixos

# Generate hardware configuration
log "Generating hardware configuration..."
nixos-generate-config --root /mnt

# ============================================
# 6. Customize Configuration
# ============================================

step "Customizing Configuration"

# Update user.nix
log "Updating user configuration..."
sed -i "s/username = \".*\"/username = \"$USERNAME\"/" modules/system/user.nix
sed -i "s|home-directory = \".*\"|home-directory = \"/home/$USERNAME/\"|" modules/system/user.nix
sed -i "s/default-locale = \".*\"/default-locale = \"$LOCALE\"/" modules/system/user.nix
sed -i "s/username = \".*\"/username = \"$GIT_USER\"/" modules/system/user.nix
sed -i "s/email = \".*\"/email = \"$GIT_EMAIL\"/" modules/system/user.nix

# Update core.nix
log "Updating system configuration..."
sed -i "s/time.timeZone = \".*\"/time.timeZone = \"$TIMEZONE\"/" modules/system/core.nix
sed -i "s/defaultLocale = \".*\"/defaultLocale = \"$LOCALE\"/" modules/system/core.nix

# Update hostname in host config
if [[ "$HOST" == "template" ]]; then
    log "Updating template hostname..."
    sed -i "s/networking.hostName = \".*\"/networking.hostName = \"$HOSTNAME\"/" \
        "modules/system/hosts/template/default.nix"
fi

# Configure GPU support
log "Configuring GPU support..."

if [[ "$NVIDIA_GPU" == true && "${ENABLE_NVIDIA:-false}" == true ]]; then
    info "Enabling NVIDIA GPU support..."

    # Create NVIDIA configuration module
    cat > /mnt/etc/nixos/modules/system/hosts/${HOST}/nvidia.nix << 'EOF'
{ config, pkgs, lib, ... }:

{
  # NVIDIA GPU configuration
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      # Enable NVIDIA modesetting
      modesetting.enable = true;

      # Use open source kernel modules (recommended for newer GPUs)
      open = true;

      # Enable NVIDIA settings
      nvidiaSettings = true;

      # Package configuration
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  # Environment variables for NVIDIA
  environment.variables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
  };

  # Kernel modules
  boot.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
}
EOF

    # Add NVIDIA module to host configuration
    if [[ "$HOST" == "template" ]]; then
        sed -i '/imports = \[/a\        nvidia-configuration' \
            "modules/system/hosts/template/default.nix"
    fi
fi

if [[ "$AMD_GPU" == true && "${ENABLE_AMD:-false}" == true ]]; then
    info "Enabling AMD GPU support..."

    # Create AMD configuration module
    cat > /mnt/etc/nixos/modules/system/hosts/${HOST}/amd.nix << 'EOF'
{ config, pkgs, lib, ... }:

{
  # AMD GPU configuration
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    amdgpu = {
      initrd.enable = true;
      overdrive = {
        enable = true;
        ppfeaturemask = "0xffffffff";
      };
    };
  };

  # Kernel modules
  boot = {
    initrd.kernelModules = [ "amdgpu" ];
    kernelModules = [ "amdgpu" "kvm-amd" ];
  };

  # CPU microcode
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
EOF

    # Add AMD module to host configuration
    if [[ "$HOST" == "template" ]]; then
        sed -i '/imports = \[/a\        amd-configuration' \
            "modules/system/hosts/template/default.nix"
    fi
fi

# Configure features
log "Configuring features..."

if [[ "$HOST" != "usb" ]]; then
    # Update feature flags in host config
    cat > /mnt/etc/nixos/modules/system/hosts/${HOST}/features.nix << EOF
{ config, pkgs, lib, ... }:

{
  # Feature flags
  serenity.features = {
    gaming = ${ENABLE_GAMING};
    mediaServer = ${ENABLE_MEDIA_SERVER};
    vr = ${ENABLE_VR};
    music = ${ENABLE_MUSIC};
    bluetooth = ${ENABLE_BLUETOOTH};
  };
}
EOF
fi

# Set initial password
log "Setting initial password..."
echo "$USERNAME:$PASSWORD" | chroot /mnt chpasswd

# ============================================
# 7. Install NixOS
# ============================================

step "Installing NixOS"

log "This may take a while depending on your internet connection..."
log "Installing NixOS with host configuration: $HOST"

# Install
nixos-install --flake ".#$HOST" --no-root-passwd

# ============================================
# 8. Post-Install Summary
# ============================================

step "Installation Complete!"

echo -e "${GREEN}"
printf '%s\n' \
  "███████╗██╗   ██╗ ██████╗ ██████╗ ███████╗███████╗███████╗" \
  "██╔════╝██║   ██║██╔═══██╗██╔══██╗██╔════╝██╔════╝██╔════╝" \
  "███████╗██║   ██║██║   ██║██████╔╝█████╗  ███████╗███████╗" \
  "╚════██║██║   ██║██║   ██║██╔══██╗██╔══╝  ╚════██║╚════██║" \
  "███████║╚██████╔╝╚██████╔╝██║  ██║███████╗███████║███████║" \
  "╚══════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝"
echo -e "${NC}"

echo -e "${BOLD}Installation Summary:${NC}"
echo "  Host:        $HOST"
echo "  Hostname:    $HOSTNAME"
echo "  Filesystem:  $FILESYSTEM"
echo "  Encryption:  $ENCRYPT"
echo "  Username:    $USERNAME"
echo "  Git User:    $GIT_USER"
echo "  Git Email:   $GIT_EMAIL"
echo "  Locale:      $LOCALE"
echo "  Timezone:    $TIMEZONE"
echo ""

if [[ "$NVIDIA_GPU" == true ]]; then
    echo "  NVIDIA GPU:  ${ENABLE_NVIDIA:-false}"
fi
if [[ "$AMD_GPU" == true ]]; then
    echo "  AMD GPU:     ${ENABLE_AMD:-false}"
fi
if [[ "$HOST" != "usb" ]]; then
    echo "  Gaming:      ${ENABLE_GAMING:-false}"
    echo "  Media Server: ${ENABLE_MEDIA_SERVER:-false}"
    echo "  VR:          ${ENABLE_VR:-false}"
    echo "  Music:       ${ENABLE_MUSIC:-false}"
    echo "  Bluetooth:   ${ENABLE_BLUETOOTH:-false}"
fi

echo ""
echo -e "${BOLD}Next Steps:${NC}"
echo "  1. Reboot:     reboot"
echo "  2. Login as:   $USERNAME"
echo "  3. Change password: passwd"
echo "  4. Update:     sudo nixos-rebuild switch --flake /etc/nixos#$HOST"
echo ""
echo -e "${BOLD}Customization:${NC}"
echo "  - Edit files in /etc/nixos/modules/"
echo "  - User config: modules/system/user.nix"
echo "  - Host config: modules/system/hosts/$HOST/"
echo "  - Features:    modules/features/"
echo ""
echo -e "${BOLD}Useful Commands:${NC}"
echo "  - Test changes:  sudo nixos-rebuild test --flake /etc/nixos#$HOST"
echo "  - Switch:        sudo nixos-rebuild switch --flake /etc/nixos#$HOST"
echo "  - Update:        cd /etc/nixos && nix flake update"
echo ""

log "Thank you for using SerenityOS!"
