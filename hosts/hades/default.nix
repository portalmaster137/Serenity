{ lib, config, pkgs, modulesPath, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./network-configuration.nix
    ../../core/config.nix

     #./modules/syncthing.nix # got nuked, wasn't functional anyway :shrug:
     #./modules/disko.nix # BROKEN
    ./modules/zfs.nix
  ];

  hardware = {

    enableAllFirmware = true;
    bluetooth.enable = false;

    graphics = {
      enable = true;
      ## Packages for integrated graphics inside Hades
      extraPackages = with pkgs; [
         #intel-compute-runtime
  	 #intel-media-driver
  	 #vaapiIntel
  	 #vaapiVdpau
  	 #libvdpau-va-gl		
      ];
    };

    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;

      amdvlk = {
        enable = true;
         #package = [ ];
         #support32Bit.enable = true;
         #supportExperimental.enable = true;
         #settings = {
         #};
      };

    };
  };

  programs = {
    ## For tweaking Radeon GPUs
    corectrl = {
      enable = true;
      gpuOverclock = {
        enable = true;
        ## Allows changing clocks and volts
        ppfeaturemask = "0xfffd7fff";
      };
    };

    tuxclocker = {
      enable = true;
      enableAMD = true;
      useUnfree = true;
    };

  };

  ## Some packages for managing the radeon GPU inside Hades
  environment.systemPackages = with pkgs; [
    umr
    radeontop
    amdgpu_top
    radeontools
    radeon-profile
    nvtopPackages.amd
  ];

}
