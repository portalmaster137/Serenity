{ self, inputs, outputs, lib, config, pkgs, ... }:

{

  imports = [
    ./hyprland.nix # Hyprland config file
  ];

  home.packages = with pkgs; [

  ];

}
