## Sway eyecandy options - https://github.com/WillPower3309/swayfx
{ self, inputs, outputs, lib, config, pkgs, ... }:

with lib;
with pkgs;

let

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
  font = "Spleen-32x64";

  bgColor = colorScheme.primary.normal.background;
  fgColor = colorScheme.primary.bright.foreground;
  acColor = colorScheme.normal.red;
  acColor2 = colorScheme.normal.yellow;

in {

  imports = [ ];

  wayland.windowManager.sway = {
    extraSessionCommands = "";
    extraConfig = "
      default_border pixel 3
      smart_corner_radius enable
      corner_radius 15
      shadows enable
      shadows_on_csd enable
      shadow_blur_radius 10
      blur enable
      blur_xray disable
      blur_passes 4
      blur_radius 1
      ";

    config = rec {

      ## Use waybar as desktop statusbar
      bars = [{
        command = "${waybar}/bin/waybar";
        position = "top";
        fonts = { size = 15.0; };
      }];

      ## Borders
      window = {
        titlebar = false;
        border = 1;
      };
      floating = { border = 1; };
      gaps.smartBorders = "on";

      ## Gaps
      gaps = {
        inner = 5;
        outer = 5;
        smartGaps = false;
      };

      ## Fonts
      fonts = {
        names = [ "Spleen-32x64" ];
        size = 10.0;
      };

      ## Colours
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

}
