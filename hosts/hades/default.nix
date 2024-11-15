{ inputs, outputs, modulesPath, lib, config, pkgs, ... }:

{
  imports = [

    ## Host specific files
    ./hardware-configuration.nix # hardware config
    ./modules # more host specific configs

    ## Shared 'core' config options
    ../../core/config.nix

  ];

  hardware = {

    ## No bluetooth inside Hades (yet)
    bluetooth.enable = false;

    graphics = {
      enable = true;
      enable32Bit = true;

      ## Packages for the iGPU inside Hades
      extraPackages = with pkgs; [
         #intel-compute-runtime
  	 #intel-media-driver
  	 #vaapiIntel
  	 #vaapiVdpau
  	 #libvdpau-va-gl		
      ];

    };

    ## Packages for the dGPU inside Hades
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
      ## Vulkan packages for the dGPU inside Hades
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
    umr
    radeontop
    amdgpu_top
    radeontools
    radeon-profile
    nvtopPackages.amd
  ];

}
