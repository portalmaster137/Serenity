{ pkgs, ... }:

{
  imports = [

    ## Host specific files
    ./modules # more host specific configs

    ## Shared 'core' config options
    ../../core/config.nix

  ];

  ## ooh, hostname - this one's important!
  networking.hostName = "orcus";

  hardware = {
  };

  services = {
  };

  programs = {
  };

  ## Some packages for managing the hardware inside Hades
  environment.systemPackages = with pkgs; [
  ];

}
