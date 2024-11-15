{ self, inputs, outputs, lib, config, pkgs, ... }:

{

  imports = [
    ./hyprland.nix # Hyprland config file
     #./scripts # Hyprland specific scripts
  ];

  home.packages = with pkgs; [

  ];

}
