{ inputs, config, pkgs, lib, ... }:
let

in {

  imports = [
    inputs.niri.homeModules.niri
    ./window-rules.nix
    #./visual.nix
    ./binds.nix
  ];

  #xdg.configFile."niri/config.kdl".source = ./niri.kdl;

  home.packages = with pkgs; [
    xwayland-satellite
  ];

  programs = {

    niri = {
      enable = true;
      package = with pkgs; niri-unstable;

      settings = {

        environment = {
          MOZ_ENABLE_WAYLAND = "1";
          NIXOS_OZONE_WL = "1";
          XDG_SESSION_TYPE = "wayland";
          XDG_CURRENT_DESKTOP = "niri";
          QT_QPA_PLATFORM = "wayland,xcb";
          QT_QPA_PLATFORMTHEME = "qt5ct";
          QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
          SDL_VIDEODRIVER = "wayland,windows";
          WLR_RENDERER = "vulkan";
        };

        xwayland-satellite = {
          enable = true;
          path = "${pkgs.xwayland-satellite}/bin/xwayland-satellite-unstable";
        };

        outputs."DP-4" = {
          mode = {
            width = 3440;
            height = 1440;
            refresh = 74.924;
          };
          position = {
            x = 1920;
            y = 0;
          };
          scale = 1.0;
          variable-refresh-rate = "on-demand";
          focus-at-startup = true;
        };
        outputs."HDMI-A-2" = {
          mode = {
            width = 1920;
            height = 1080;
            refresh = 60.0;
          };
          position = {
            x = 0;
            y = 360;
          };
          scale = 1.0;
        };

        input = {
          focus-follows-mouse = {
            enable = true;
            max-scroll-amount = "0%";
          };
          keyboard = { numlock = true; };
          mouse = {
            enable = true;
            natural-scroll = false;
          };
          touchpad = {
            enable = true;
            natural-scroll = true;
          };
          trackpoint = { enable = true; };
        };

        prefer-no-csd = true;
        layout = {
          gaps = 8;
          struts = {
            left = 2;
            right = 2;
            top = 2;
            bottom = 4;
          };
          center-focused-column = "never";
          preset-column-widths = [
            #{proportion = 0.25;}
            { proportion = 0.33333; }
            { proportion = 0.5; }
            {
              proportion = 0.66667;
            }
            #{proportion = 0.75;}
            { proportion = 1.0; }
          ];
          border = { enable = false; };
          focus-ring = {
            enable = true;
            width = 2;
            active.gradient = {
              from = "#00cdff";
              to = "#80c8ff";
              angle = 45;
            };
            inactive.gradient = {
              from = "#705050";
              to = "#505070";
              angle = 45;
            };
          };
        };
        animations = {
          enable = true;
          slowdown = 1.25;
        };

        spawn-at-startup = [
          {argv = ["waybar"]; }
          #{argv = ["kitty" "btop"]; }
          {argv = ["swaybg" "-m" "fill" "-i" "~/Pictures/SerenityOS Branding/SerenityOS Wallpapers/duskGradient.png"]; }
        ];

        hotkey-overlay = {
          skip-at-startup = true;
          hide-not-bound = false;
        };

      };
    };

  };
}
