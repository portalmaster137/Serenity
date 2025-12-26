{ inputs, config, pkgs, lib, flakePath, homeDir, ... }:
let
  
in {
  imports = [ inputs.niri.homeModules.niri ];
  xdg.configFile."niri/config.kdl".source = ./niri.kdl;

  programs = {

    niri = {
      enable = true;
      package = with pkgs; niri-unstable;
      settings = {
        outputs."DP-4".scale = 1.0;
      };
    };

  };
} 
