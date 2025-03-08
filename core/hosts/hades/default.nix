{ pkgs, ... }:

{
  imports = [

    ## Host-specific config files
    #./disko.nix
    ./network.nix
    ./hardware.nix
    ## Shared 'core' config options
    ../../../core
    ## Host-specific core modules
    ../../../core/modules/zfs.nix
    ../../../core/modules/gaming.nix
    ../../../core/modules/jellyfin.nix

  ];

  ## ## ## ## ##

  boot = {

    kernelPackages = pkgs.linuxPackages_latest;

    supportedFilesystems = [ "vfat" "ext4" ];

    loader = {
      grub = {
        enable = true;
        device = "/dev/nvme0n1";
        enableCryptodisk = true;
      };
    };

    initrd.luks.devices = {
      root = {
        # Use https://nixos.wiki/wiki/Full_Disk_Encryption
        device = "/dev/disk/by-uuid/5526aab7-b779-4fc8-95bd-9452bc3a9232";
        preLVM = true;
      };
    };

  };

  ## ## ## ## ##

  ## ooh, hostname - this one's important!
  networking.hostName = "hades";

  hardware = {

    ## Enable bluetooth inside Hades
    bluetooth.enable = true;

    ## GPU and graphics
    graphics = {
      enable = true;
      enable32Bit = true;
      ## Packages for the iGPU inside Hades
      extraPackages = with pkgs; [
        intel-compute-runtime
        intel-media-driver
        libvdpau-va-gl
        vaapiIntel
        vaapiVdpau
      ];
    };
    ## Packages for the dGPU inside Hades
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
      ## Vulkan packages for the dGPU inside Hades
      amdvlk = {
        #enable = false;
        #package = [ ];
        #support32Bit.enable = false;
        #supportExperimental.enable = false;
        #settings = {
        #};
      };
    };
  };

  services = { xserver.videoDrivers = [ "amdgpu" ]; };

  programs = {
    ## For tweaking system performance
    corectrl = {
      enable = true;
      ## Allows tweaking GPU performance
      gpuOverclock = {
        enable = true;
        ## Needed for radeon GPU overclocking
        ppfeaturemask = "0xfffd7fff";
      };
    };
    ## Performance tweaking continued
    tuxclocker = {
      enable = true;
      enableAMD = true;
      useUnfree = true;
    };
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
