{ pkgs, ... }:

{
  imports = [

    ## Host-specific config files
    ./network.nix
    ./hardware.nix
    ./bluetooth.nix
    ## Shared 'core' config options
    ../../../core
    ## Host-specific core modules
    ../../../core/zfs.nix
    ../../../core/sync.nix
    ../../../core/gaming.nix

  ];

  ## ooh, hostname - this one's important!
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

      ## Uhhhhhhh
      #Asphodel = { # secondary partition on Tartarus drive
      #device = "/dev/disk/by-uuid/45f5f6ad-a676-4bc1-ad4b-e3e26b5697f4";
      #preLVM =false;
      #};
    #};

  };

  ## ## ## ## ##

  hardware = {

    ## GPU and graphics
    graphics = {
      enable = true;
      enable32Bit = true;
      ## Packages for the iGPU inside Hades
      ## - disabled for now:tm:
      extraPackages = with pkgs;
        [
          #intel-compute-runtime
          #intel-media-driver
          #libvdpau-va-gl
          #vaapiIntel
          #vaapiVdpau
        ];
    };
    ## Driver packages for the dGPU inside Hades
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };
  };

  services = {
    xserver.videoDrivers = [ "amdgpu" ]; # sets X to use amdgpu drivers
  };

  programs = {
    ## For tweaking system performance
    #corectrl = {
    #enable = true;
    ## Allows tweaking GPU performance
    #gpuOverclock = {
    #enable = true;
    ## Needed for radeon GPU overclocking
    #ppfeaturemask = "0xfffd7fff";
    #};
    #};
    ## Performance tweaking continued
    #tuxclocker = {
    #enable = true;
    #enableAMD = true;
    #useUnfree = true;
    #};
  };

  ## Some packages for managing the hardware inside Hades
  environment.systemPackages = with pkgs; [
    #umr
    lact
    radeontop
    #amdgpu_top
    #radeontools
    #radeon-profile
    nvtopPackages.amd
  ];

  ## Systemd services for lact
  systemd = {
    packages = with pkgs; [ lact ];
    services.lactd.wantedBy = [ "multi-user.target" ];
  };

}
