{ inputs, outputs, modulesPath, lib, config, pkgs, ... }:

{
  imports = [

    ## Host specific files
    ./hardware-configuration.nix # hardware config
    ./network-configuration.nix # network config
    ./modules # more host specific configs

    ## Shared 'core' config options
    ../../config.nix

  ];

  hardware = {

    ## Enable bluetooth inside Persephone
    bluetooth.enable = true;

    graphics = {
      enable = true;

      ## Packages for the iGPU inside Persephone
      extraPackages = with pkgs; [
        intel-compute-runtime
  	intel-media-driver
  	vaapiIntel
  	vaapiVdpau
  	libvdpau-va-gl		
      ];

    };

  };

  programs = {

    ## For tweaking system performance
    corectrl = {
      enable = true;
    };
    ## Performance tweaking continued
    tuxclocker = {
      enable = true;
      useUnfree = true;
    };

  };

  ## Some packages for managing the hardware inside Persephone
  environment.systemPackages = with pkgs; [
    nvtopPackages.intel
  ];

}
