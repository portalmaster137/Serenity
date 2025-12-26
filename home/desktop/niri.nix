{ lib, pkgs, config, ... }:
with lib;
with pkgs;

{

  home = {
    packages = with pkgs; [ xwayland-satellite ];

    programs.niri = {
      enable = true;
      settings = {
        binds = { "Mod+Enter".action = { spawn = [ "kitty" ]; }; };
      };
    };

  };
}
