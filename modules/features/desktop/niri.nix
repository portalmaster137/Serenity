{ self, inputs, ... }: {

  # niri window manager module declaration
  flake.nixosModules.niri =
    { pkgs, lib, ... }:

    {

      imports = [

        # for home manager functionality
        inputs.home-manager.nixosModules.home-manager

        # for niri binary cache from epireyn
        # disable if untrusted
        # conflicts with unstable overlay
        #inputs.niri.nixosModules.niri

        # extra niri config files
        ./binds.nix
        ./window-rules.nix

      ];

      # for niri binary cache from epireyn
      # disable if untrusted
      #niri-flake.cache.enable = true;

      # for latest niri versions - disable if using binary cache
      nixpkgs.overlays = [ inputs.niri.overlays.niri ];

      # packages for desktop environment
      environment.systemPackages = with pkgs; [
        jq # unsure what this is for - research time?
        xwayland-satellite # niri xwayland support - disable if using unstable
        #xwayland-satellite-unstable # niri xwayland support - disable if using stable
      ];

      # session management
      programs.uwsm = {
        enable = true;
        # configures uwsm to launch niri
        waylandCompositors.niri = {
          prettyName = "Niri";
          comment = "Niri scrolling WM managed by UWSM";
          # points to niri binary and declares it as a session
          binPath = "/run/current-system/sw/bin/niri";
          extraArgs = [ "--session" ];
        };
      };

      # enables niri globally
      programs.niri = {
        enable = true;
        # use latest nixpkgs version - disable if using binary cache or unstable
        package = with pkgs; niri;
        # use latest unstable version - disable if using binary cache or stable
        #package = with pkgs; niri-unstable;
      };

      # niri personalisation
      home-manager.users.serenity = {

        # for niri home manager module
        imports = [ inputs.niri.homeModules.niri ];

        programs.niri = {
          # enables niri within home manager
          enable = true;
          # use latest nixpkgs version - disable if using binary cache or unstable
          package = with pkgs; niri;
          # uses latest unstable version - disable if using binary cache or stable
          #package = with pkgs; niri-unstable;
          settings = {

            # xwayland implementation
            xwayland-satellite = {
              enable = true;
              # use niri-stable matching version - disable if using unstable
              path = lib.getExe pkgs.xwayland-satellite;
              # use niri-unstable matching version - disable if using stable
              #path = lib.getExe pkgs.xwayland-satellite-unstable;
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

            # input settings - keybinds are elsewhere
            hotkey-overlay = {
              hide-not-bound = true;
              skip-at-startup = true;
            };
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
            center-focused-column = "never";
            overview = {
              workspace-shadow.enable = false;
            };
            animations = {
              enable = true;
              slowdown = 1.25;
            };
            prefer-no-csd = true;
            border.enable = false;
            layout = {
              # window|window gaps
              gaps = 8;
              #window|screen edge gaps
              struts = {
                left = 2;
                right = 2;
                top = 2;
                bottom = 4;
              };
            };
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

        };

      };

    };

}
