{ pkgs, user, ... }:

{

  imports = [
    # Host-specific config files
    ./network.nix
    ./hardware.nix
    ./bluetooth.nix
    # Shared 'core' config options
    ../../../core
    # Host-specific core modules
    ../../../core/zfs.nix
    ../../../core/gaming.nix
    ../../../core/virtualisation.nix
  ];

  # Name of this computer ?
  networking.hostName = "hades";

  # Boot options
  boot = {
    # Linux kernel version selection
    kernelPackages = pkgs.linuxPackages_latest; # latest compatible
    # Bootloader settings
    loader = {
      systemd-boot.enable = true; # better than grub
      efi.canTouchEfiVariables = true; # needed for stuff:tm:
    };
    # Filesystem support at boot
    supportedFilesystems = [ 
      "vfat" # fat32
      "ext4" # ext4 
      #"ntfs" # windows lol
    ];
    # Decryption via LUKS
    initrd.luks = {
      # Primary boot drive
      devices."luks-55f7d546-fac9-4ea0-a21e-4c50ecc0d67d" = {
        device = "/dev/disk/by-uuid/55f7d546-fac9-4ea0-a21e-4c50ecc0d67d";
      };
      # Secondary storage drive
      #devices.Asphodel = { # secondary partition on Tartarus drive
        #device = "/dev/disk/by-uuid/45f5f6ad-a676-4bc1-ad4b-e3e26b5697f4";
        #preLVM = false;
      #};
    };
  };

  # Hardware
  services.xserver.videoDrivers = [ "amdgpu" ]; # makes x use amd
  hardware = {
    # GPU and graphics
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    # Driver packages for the dGPU inside Hades
    amdgpu = {
      overdrive.enable = true; # overclocking lol
      initrd.enable = true; # for video at boot
      opencl.enable = true; # gpu tech idk lol
    };
  };

  # Peripherals
  hardware.openrazer = {
    enable = true; # enables openrazer daemon
    users = [ "${user}" ]; # giving primary user permissions (again)
  };
  users.users.${user} = { # giving primary user permissions (again)
    extraGroups = [ "openrazer" ];
  };
  services = {
    hardware.openrgb.enable = true; # rgb control
    input-remapper = { 
      enable = true; # needed to remap some stuff
      enableUdevRules = true; # hotplug support
    };
  };

  # Packages
  environment.systemPackages = with pkgs; [

    # Hardware & Firmware
    radeontop # monitoring
    nvtopPackages.amd # monitoring

    # peripherals & Input
    input-remapper # Input control
    razergenie # Razer frontend
    openrazer-daemon # Razer daemon
    openrgb-with-all-plugins # RGB control

  ];

}
