{ self, inputs, ... }:

{

  # niri window manager module declaration
  flake.nixosModules.niri =

    { pkgs, lib, ... }:

    {

      # for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # for latest niri versions
      nixpkgs.overlays = [ inputs.niri.overlays.niri ];

      # packages for desktop environment
      environment.systemPackages = with pkgs; [
        jq # unsure what this is for - research time?
        xwayland-satellite # niri xwayland support
      ];

      # session management
      programs.uwsm = {
        enable = false;
        # configures uwsm to launch niri
        waylandCompositors.niri = {
          prettyName = "Niri";
          comment = "Niri scrolling WM managed by UWSM";
          # points to niri binary and declares it as a session
          binPath = "${pkgs.niri}/bin/niri";
          extraArgs = [ "--session" ];
        };
      };

      # enables niri globally
      programs.niri = {
        enable = true;
        # use latest nixpkgs version
        package = with pkgs; niri;
      };

      # niri personalisation
      home-manager.users.serenity =

        { config, ... }:

        {

          # for niri home manager module
          imports = [ inputs.niri.homeModules.niri ];

          programs.niri = {
            # enables niri within home manager
            enable = true;
            # use latest nixpkgs version
            package = with pkgs; niri;
            settings = {

              # xwayland implementation
              xwayland-satellite = {
                enable = true;
                # use niri-stable matching version
                path = lib.getExe pkgs.xwayland-satellite;
              };

              # environment variables
              environment = {
                # display
                DISPLAY = ":0";
                WLR_RENDERER = "vulkan";
                NIXOS_OZONE_WL = "1";
                SDL_VIDEODRIVER = "wayland";
                # xdg variables
                XDG_SESSION_TYPE = "wayland";
                XDG_CURRENT_DESKTOP = "niri";
                # qt variables
                QT_QPA_PLATFORM = "wayland;xcb";
                QT_QPA_PLATFORMTHEME = "qt5ct";
                QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
                # native wayland firefox
                MOZ_ENABLE_WAYLAND = "1";
              };

              # display configuration
              outputs."DP-4" = {
                # display scaling
                scale = 1.2;
                # window focus?
                focus-at-startup = true;
                # resolution config
                variable-refresh-rate = true;
                mode = {
                  width = 3440;
                  height = 1440;
                  refresh = 74.924;
                };
                # grid position for this display
                position = {
                  x = 0;
                  y = 0;
                };
              };

              # input settings - keybinds further below
              input = {
                # window focus
                focus-follows-mouse = {
                  enable = true;
                  max-scroll-amount = "0%";
                };
                # keyboard and pointing devices
                keyboard.numlock = true;
                trackpoint = {
                  enable = true;
                };
                touchpad = {
                  enable = true;
                  natural-scroll = true;
                };
                mouse = {
                  enable = true;
                  natural-scroll = false;
                  accel-speed = 1.0;
                  accel-profile = "flat";
                };
              };

              # workspaces
              workspaces."01sys" = {
                name = "System";
                open-on-output = "DP-4";
              };

              # autostart
              spawn-at-startup = [
                {
                  # necessary for xwayland functionality
                  argv = [ "xwayland-satellite" ];
                }
                {
                  # spawns the desktop shell
                  argv = [ "noctalia" ];
                }
                {
                  # spawns a terminal running btop
                  argv = [
                    "kitty"
                    "btop"
                  ];
                }
              ];

              # visual settings
              prefer-no-csd = true;
              overview = {
                workspace-shadow.enable = false;
              };
              animations = {
                enable = true;
                slowdown = 1.25;
              };
              layout = {
                # remove backdrop colour
                background-color = "transparent";
                center-focused-column = "never";
                # window|window gaps
                gaps = 8;
                #window|screen edge gaps
                struts = {
                  left = 2;
                  right = 2;
                  top = 2;
                  bottom = 4;
                };
                # using focus ring instead of a border
                border.enable = false;
                # highlights the focused window bounds
                focus-ring = {
                  enable = true;
                  width = 2;
                  #focus ring colour
                  active.gradient = {
                    angle = 45;
                    from = "#00cdff";
                    to = "#80c8ff";
                  };
                };
                # used when increasing window size in steps
                preset-column-widths = [
                  {
                    proportion = 0.33;
                  }
                  {
                    proportion = 0.5;
                  }
                  {
                    proportion = 0.67;
                  }
                  {
                    proportion = 1.0;
                  }
                ];

              };

              layer-rules = [

                # pushes wallpaper set by noctalia to lowest layer
                {
                  matches = [ { namespace = "^noctalia-wallpaper*"; } ];
                  place-within-backdrop = true;
                }

              ];

              window-rules = [

                # sets corner radius for all windows
                {
                  clip-to-geometry = true;
                  draw-border-with-background = false;
                  geometry-corner-radius =
                    let
                      radius = 16.0;
                    in
                    {
                      bottom-left = radius;
                      bottom-right = radius;
                      top-left = radius;
                      top-right = radius;
                    };
                }

                # sets sizing and position of floating windows
                {
                  matches = [ { is-floating = true; } ];
                  opacity = 0.95;
                  shadow.enable = true;
                  max-width = 1720;
                  max-height = 720;
                  default-floating-position = {
                    relative-to = "top-left";
                    x = 1720;
                    y = 720;
                  };
                }

                # rules for specific windows
                {
                  # kitty opacity
                  matches = [ { app-id = "kitty"; } ];
                  opacity = 0.95;
                }
                {
                  # startup btop spawns on specific workspace
                  matches = [
                    {
                      at-startup = true;
                      title = "btop";
                    }
                  ];
                  open-on-output = "DP-4";
                  open-on-workspace = "System";
                  open-maximized = true;
                }
                {
                  # calculator spawns floating
                  matches = [ { title = "calculator"; } ];
                  open-floating = true;
                  open-focused = true;
                }

              ];

              # keybinds
              # https://github.com/niri-wm/niri/wiki/Configuration:-Key-Bindings
              hotkey-overlay = {
                hide-not-bound = true;
                skip-at-startup = true;
              };
              binds = with config.lib.niri.actions; {

                # debug and utility
                "Mod+Shift+Slash".action = show-hotkey-overlay; # shows help
                "Mod+Shift+Escape" = {
                  action = toggle-keyboard-shortcuts-inhibit;
                  allow-inhibiting = false; # ensures niri binds are read
                };
                "Mod+Shift+P".action = power-off-monitors; # turn displays off
                "Ctrl+Alt+Delete".action = quit; # log out

                # task management
                "Mod+Q".action = close-window;
                "Mod+Q".repeat = false;
                "Mod+O".action = toggle-overview;
                "Mod+O".repeat = false;
                "Mod+Tab".action = spawn "${pkgs.wofi}/bin/wofi";
                "Mod+Tab".repeat = false; # launcher
                "Mod+Return".action = spawn "${pkgs.kitty}/bin/kitty";
                "Mod+Return".repeat = false; # terminal

                # screen capture
                "Mod+S".action.screenshot = {
                  show-pointer = false;
                };
                "Mod+Shift+S".action.screenshot-window = [ ];
                "Mod+Shift+Alt+S".action.screenshot-screen = {
                  show-pointer = true;
                };

                # focus controls
                "Mod+H".action = focus-column-left;
                "Mod+J".action = focus-workspace-down;
                "Mod+K".action = focus-workspace-up;
                "Mod+L".action = focus-column-right;
                "Mod+Left".action = focus-column-left;
                "Mod+Down".action = focus-column-down;
                "Mod+Up".action = focus-workspace-up;
                "Mod+Right".action = focus-workspace-right;
                "Mod+WheelScrollDown".action = focus-workspace-down;
                "Mod+WheelScrollDown".cooldown-ms = 100;
                "Mod+WheelScrollUp".cooldown-ms = focus-workspace-up;
                "Mod+WheelScrollUp".cooldown-ms = 100;

                # movement controls
                "Mod+Shift+H".action = move-column-left;
                "Mod+Shift+J".action = move-column-to-workspace-down;
                "Mod+Shift+J".action = move-column-to-workspace-up;
                "Mod+Shift+J".action = move-column-to-right;
                "Mod+Shift+Left".action = move-column-to-left;
                "Mod+Shift+Down".action = move-column-to-workspace-down;
                "Mod+Shift+Up".action = move-column-to-workspace-up;
                "Mod+Shift+Right".action = move-column-to-workspace-right;
                "Mod+Shift+WheelScrollDown".action = move-column-to-workspace-down;
                "Mod+Shift+WheelScrollDown".cooldown-ms = 100;
                "Mod+Shift+WheelScrollUp".cooldown-ms = move-column-to-workspace-up;
                "Mod+Shift+WheelScrollUp".cooldown-ms = 100;

                # size controls
                #"Mod+1".action = set-column-width "25%";
                #"Mod+2".action = set-column-width "50%";
                #"Mod+3".action = set-column-width "75%";
                #"Mod+4".action = set-column-width "100%";
                "Mod+Minus".action = switch-preset-column-width-back;
                "Mod+Equal".action = switch-preset-column-width;
                "Mod+Shift+Minus".action = switch-preset-window-height-back;
                "Mod+Shift+Equal".action = switch-preset-window-height;
                "Mod+C".action = center-visible-columns;
                "Mod+F".action = maximize-column;
                "Mod+Shift+F".action = fullscreen-window;
                "Mod+Ctrl+F".action = expand-column-to-available-width;
                "Mod+Space".action = toggle-window-floating;
                "Mod+Shift+Space".action = switch-focus-between-floating-and-tiling;

              };

            };

          };

        };

    };

}
