{ self, inputs, outputs, lib, config, pkgs, ... }:
with lib;
with pkgs;
let

  left = "h";
  down = "j";
  up = "k";
  right = "l";
  bg-color = "#424242";
  inactive-bg-color = "#424242";
  text-color = "#4f97d7";
  inactive-text-color = "#676E7D";
  urgent-bg-color = "#E53935";

  colorSchemeDark = rec {
    primary = {
      normal = {
        background = "181818";
        foreground = "b9b9b9";
      };
      bright = {
        background = bright.black;
        foreground = bright.white;
      };
    };
    normal = {
      black = "252525";
      gray = "5b5b5b";
      red = "ed4a46";
      green = "70b433";
      yellow = "dbb32d";
      blue = "368aeb";
      magenta = "eb6eb7";
      cyan = "3fc5b7";
      white = "777777";
    };
    bright = {
      black = "3b3b3b";
      gray = "7b7b7b";
      red = "ff5e56";
      green = "83c746";
      yellow = "efc541";
      blue = "4f9cfe";
      magenta = "ff81ca";
      cyan = "56d8c9";
      white = "dedede";
    };
  };

  colorScheme = colorSchemeDark;
  font = "Roboto";

  bgColor = colorScheme.primary.normal.background;
  fgColor = colorScheme.primary.bright.foreground;
  acColor = colorScheme.normal.red;
  acColor2 = colorScheme.normal.yellow;

in {
  imports = [
    #./sway-style.nix
  ];

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

      ## Use waybar as desktop statusbar
      bars = [{
        command = "${waybar}/bin/waybar";
        position = "top";
        fonts = { size = 15.0; };
      }];

      focus = {
        followMouse = true;
        mouseWarping = false;
        newWindow = "smart";
      };

      keybindings = { };

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

      modifier = "Mod4";

      window = { border = 0; };

      floating = {
        modifier = "Mod4";
        border = 0;
      };

      fonts = {
        names = [ "Spleen" ];
        size = 9.0;
      };

      colors = {
        focused = {
          border = bg-color;
          childBorder = bg-color;
          background = bg-color;
          text = text-color;
          indicator = "#00ff00";
        };
        unfocused = {
          border = inactive-bg-color;
          childBorder = inactive-bg-color;
          background = inactive-bg-color;
          text = inactive-text-color;
          indicator = "#00ff00";
        };
        focusedInactive = {
          border = inactive-bg-color;
          childBorder = inactive-bg-color;
          background = inactive-bg-color;
          text = inactive-text-color;
          indicator = "#00ff00";
        };
        urgent = {
          border = urgent-bg-color;
          childBorder = urgent-bg-color;
          background = urgent-bg-color;
          text = text-color;
          indicator = "#00ff00";
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
