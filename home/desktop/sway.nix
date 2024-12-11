{ self, inputs, outputs, lib, config, pkgs, ... }:
with lib;
with pkgs;
let

  left = "h";
  down = "j";
  up = "k";
  right = "l";

in {
  imports = [ ./swayfx.nix ];

  wayland.windowManager.sway = {
    enable = true;
    extraSessionCommands = "";
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
      #variables = [
      #];
    };

    config = rec {

      output = {
        eDP-1 = {
          ## Set HIDP scale (pixel integer scaling)
          scale = "1";
        };
      };

      ## Use Wofi as menu
      menu = "wofi --show run";
      ## Use kitty as default terminal
      terminal = "kitty";
      ## Startup scripts and programs
      startup = [ { command = "startup"; } { command = "kitty"; } ];
      modifier = "Mod4";
      floating = { modifier = "Mod4"; };

      ## Window and focus settings
      window = { };
      focus = {
        followMouse = true;
        mouseWarping = false;
        newWindow = "smart";
      };

      keybindings = mkOptionDefault (import ./keybinds.nix { inherit pkgs; });

      modes = {
        resize = {
          Escape = "mode default";
          Return = "mode default";
          "${down}" = "resize grow height 10 px or 10 ppt";
          "${left}" = "resize shrink width 10 px or 10 ppt";
          "${right}" = "resize grow width 10 px or 10 ppt";
          "${up}" = "resize shrink height 10 px or 10 ppt";
        };
      };

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
