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

  ];

  # ooh, hostname - this one's important!
  networking.hostName = "hades";

  ## ## ## ## ##

  boot = {

    kernelPackages =
      pkgs.linuxPackages_latest; # use the latest compatible linux kernel
    supportedFilesystems =
      [ "vfat" "ext4" ]; # adds fat32 and ext3 filesystems to defaults

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
      	enable = true;
      };
    };

    initrd.luks.devices."luks-55f7d546-fac9-4ea0-a21e-4c50ecc0d67d".device = "/dev/disk/by-uuid/55f7d546-fac9-4ea0-a21e-4c50ecc0d67d";

      # Uhhhhhhh
      #Asphodel = { # secondary partition on Tartarus drive
      #device = "/dev/disk/by-uuid/45f5f6ad-a676-4bc1-ad4b-e3e26b5697f4";
      #preLVM =false;
      #};
    #};

  };

  ## ## ## ## ##

  # Hades specific Razer peripherals
  users.users.${user}.extraGroups = [ "openrazer" ];
  hardware.openrazer = {
    enable = true;
    users = [ "${user}" ];
  };

  hardware = {

    # GPU and graphics
    graphics = {
      enable = true;
      enable32Bit = true;
      # Packages for the iGPU inside Hades
      # - disabled for now:tm:
      extraPackages = with pkgs;
        [
          #intel-compute-runtime
          #intel-media-driver
          #libvdpau-va-gl
          #vaapiIntel
          #vaapiVdpau
        ];
    };
    # Driver packages for the dGPU inside Hades
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };
  };

  services = {

    # Tells X to use amdgpu drivers
    xserver.videoDrivers = [ "amdgpu" ];
    # Openrgb background service
    hardware.openrgb.enable = true;
    # Peripheral input remapping
    input-remapper = {
      enable = true;
      enableUdevRules = true; # hotplug support
    };
  };

  programs = {
    # For tweaking system performance
    #corectrl = {
    #enable = true;
    # Allows tweaking GPU performance
    #gpuOverclock = {
    #enable = true;
    # Needed for radeon GPU overclocking
    #ppfeaturemask = "0xfffd7fff";
    #};
    #};
    # Performance tweaking continued
    #tuxclocker = {
    #enable = true;
    #enableAMD = true;
    #useUnfree = true;
    #};
  };

  # Some packages for managing the hardware inside Hades
  environment.systemPackages = with pkgs; [

    # GPU firmware and control
    #umr # tweaking
    lact # tweaking
    radeontop # monitoring
    #amdgpu_top # monitoring
    #radeontools # tweaking
    #radeon-profile # tweaking
    nvtopPackages.amd # monitoring

    # peripherals & Input
    input-remapper # Input control
    razergenie # Razer frontend
    #openrazer # Razer firmware
    openrazer-daemon # Razer daemon
    #polychromatic # Razer frontend
    openrgb-with-all-plugins # RGB control
  ];

  # Systemd services for lact
  systemd = {
    packages = with pkgs; [ lact ];
    services.lactd.wantedBy = [ "multi-user.target" ];
  };

}
