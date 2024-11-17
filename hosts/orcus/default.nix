{ pkgs, ... }:

{
  imports = [

    ## Host specific files
    ./hardware-configuration.nix # hardware config
    ./modules # more host specific configs

    ## Shared 'core' config options
    ../../core/config.nix

  ];

  ## ooh, hostname - this one's important!
  networking.hostName = "orcus";

  hardware = {

    ## No bluetooth inside Orcus
    bluetooth.enable = false;

    ## Packages for the iGPU inside Orcus
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

  services = {
  };

  programs = {

    ## For tweaking system performance
    corectrl = {
      enable = true;
    };



  };

  ## Some packages for managing the hardware inside Hades
  environment.systemPackages = with pkgs; [
  ];

}
