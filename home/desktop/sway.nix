{ lib, pkgs, config, ... }:
with lib;
with pkgs;
let

in {
  imports = [ ./swayfx.nix ];

  wayland.windowManager.sway = {
    enable = true;
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland,windows
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export XDG_CURRENT_DESKTOP=sway
      export XDG_SESSION_TYPE=wayland
    '';
    extraConfig = "";
    xwayland = true;
    checkConfig = false;
    package = pkgs.swayfx;
    wrapperFeatures = {
      base = true;
      gtk = true;
    };
    systemd = {
      enable = true;
      #xdgAutostart = true;
      #extraCommands = [
      #];
      ## Needed for soteria - https://github.com/NixOS/nixpkgs/issues/373290
      variables = [ "--all" ];
    };

    swaynag = {
      enable = true;
      settings = { };
    };

    config = {

      output = {
        eDP-1 = {
          ## Set HIDP scale (pixel integer scaling)
          scale = "1";
        };
      };

      defaultWorkspace = "workspace number 0";

      ## Use Wofi as menu
      menu = "menu";
      ## Use kitty as default terminal
      terminal = "kitty";
      ## Startup scripts and programs
      startup = [
        #{ command = "startupExtra"; }
        { command = "startup"; } # defined in `home/scripts/startup.nix`
        { command = "kitty"; }
        { command = "kitty btop"; }
      ];
      modifier = "Mod4";
      floating = {
        modifier = "Mod4";
        titlebar = false;
      };

      ## Window and focus settings
      window = { };
      focus = {
        followMouse = true;
        mouseWarping = false;
        newWindow = "smart";
      };

      keybindings =
        mkOptionDefault (import ./keybinds.nix { inherit pkgs config; });

    };
  };

  home = {
    packages = with pkgs; [ ];

    sessionVariables = {
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "sway";
      SDL_VIDEODRIVER = "wayland";
      # needs qt5.qtwayland in systemPackages
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };
  };

}
