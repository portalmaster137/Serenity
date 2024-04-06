# This is the home-manager configuration file
# - (replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

  imports = [
  # to use home-manager modules from other flakes(nix-colors):
    # inputs.nix-colors.homeManagerModule

    ./hyprland.nix
  ];


  # Packages:
  home.packages = with pkgs; [

    steam

  ];

  # Programs:
  programs = {
  	home-manager.enable = true;
  	
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
