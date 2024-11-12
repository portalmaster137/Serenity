{ self, inputs, outputs, lib, config, pkgs, ... }:

{

  imports = [
    ./hyprland.nix  
  ];

  home.packages = with pkgs; [

  ];

}
