{ pkgs, wallpaper, ... }:
let

  startup = pkgs.writeShellScriptBin "startup" ''
    # Because HM enabling services suck.

    systemctl --user start sops-nix

    systemctl --user start hyprpolkitagent

    swww init & sleep 0.1

    swww img ${wallpaper}
  '';

  startupExtra = pkgs.writeShellScriptBin "startupExtra" ''

    otd-gui

    easyeffects

    nicotine-plus

    vesktop
  '';

in { home.packages = [ startup startupExtra ]; }
