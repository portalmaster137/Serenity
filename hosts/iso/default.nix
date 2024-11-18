{ pkgs, ... }:

{
  imports = [

    ## Host specific files
     #<nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
     #<nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
    ./modules # more host specific configs

    ## Shared 'core' config options
    ../../core/config.nix

  ];

  ## ooh, hostname - this one's important!
  networking.hostName = "installer";

  hardware = {
  };

  services = {
  };

  programs = {
    git.enable = true;
    fish.enable = true;
  };

  ## Some packages for managing the hardware inside Hades
  environment.systemPackages = with pkgs; [
    wofi
    kitty
    calamares
    calamares-nixos
    calamares-nixos-extensions
    nix-deploy
    nix-simple-deploy
    nixos-install-tools
    installation-cd-minimal
    installer

  ];

  home-manager.users.nixos = import ../../home;
  users.extraUsers.root.password = "nixos";

}
