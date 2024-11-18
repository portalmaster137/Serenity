{ pkgs, ... }:

{
  imports = [

    ## Host specific files
    #./hardware-configuration.nix # hardware config
    #./network-configuration.nix # network config
    ./modules/network.nix # more host specific configs

    ## Shared 'core' config options
    ../../core/config.nix

  ];

  ## ooh, hostname - this one's important!
  networking.hostName = "persephone";

  hardware = {

    ## Enable bluetooth inside Persephone
    bluetooth.enable = true;

    ## Packages for the iGPU inside Persephone
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-compute-runtime
  	    intel-media-driver
  	    libvdpau-va-gl
  	    vaapiIntel
  	    vaapiVdpau
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
