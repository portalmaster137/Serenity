{ inputs, outputs, modulesPath, lib, config, pkgs, ... }:

{
  imports = [

    ## Host specific files
    ./hardware-configuration.nix # hardware config
    ./modules # more host specific configs

    ## Shared 'core' config options
    ../../core/config.nix

  ];

  ## ooh, hostname - this one's important!
  networking.hostName = "hades";

  hardware = {

    ## No bluetooth inside Hades (yet)
    bluetooth.enable = false;

    ## GPU and graphics
    graphics = {
      enable = true;
       #enable32Bit = false;
      ## Packages for the iGPU inside Hades
      extraPackages = with pkgs; [
         #intel-compute-runtime
  	 #intel-media-driver
  	 #libvdpau-va-gl
  	 #vaapiIntel
  	 #vaapiVdpau
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
    packages = with pkgs; [
      lact
    ];
    services.lactd.wantedBy = [ "multi-user.target" ];
  };

}
