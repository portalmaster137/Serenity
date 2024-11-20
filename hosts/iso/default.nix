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
    nixos-install-tools

  ];

   #home-manager.users.nixos = import ../../home/users;
   #users.extraUsers.root.password = "nixos";

}
