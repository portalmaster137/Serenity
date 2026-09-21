{
  self,
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

let

  widthDivisions = [
    1.0
    2.0
    3.0
    4.0
  ];
  heightDivisions = [
    1.0
    2.0
    3.0
    4.0
  ];

  # black magic, expected output:
  # [ { proportion = 1.0 / 1.0 }
  # { proportion = 1.0 / 2.0 }
  # ...
  # { proportion = 2.0 / 1.0 }
  # { proportion = 2.0 / 3.0 }
  #	...
  # { proportion = 4.0 / 4.0 } ]
  getProportions =
    divisions:
    lib.lists.unique (
      lib.lists.flatten (
        # TODO: make this a callable function
        map (x: map (y: { proportion = x / y; }) divisions) divisions
      )
    );

  # then get all the unique outputs (removing double ups of 0.5 or others)
  # just getting all the values below 1
  columnWidths = getProportions widthDivisions;
  columnWidthsFiltered = builtins.filter (x: builtins.lessThan x.proportion 1.0) columnWidths;
  windowHeights = getProportions heightDivisions;
  windowHeightsFiltered = builtins.filter (x: builtins.lessThan x.proportion 1.0) windowHeights;

in

{

  flake.nixosModules.niri-binds =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {

      # for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # niri personalisation
      home-manager.users.serenity = {

        imports = [ inputs.niri.homeModules.niri ];

        # black magic for column widths
        programs.niri.settings.layout = {
          preset-column-widths =
            builtins.sort
              # sort list for predictable behaviour
              (a: b: builtins.lessThan a.proportion b.proportion)
              columnWidthsFiltered;
          default-column-width.proportion = 1.0 / 3.0;
          preset-window-heights = builtins.sort (
            a: b: builtins.lessThan a.proportion b.proportion
          ) windowHeightsFiltered;
        };

        # actual keybinds
        programs.niri.settings.binds = with config.lib.niri.actions; {

          # Debug & Utility
          "Mod+Shift+Slash".action = show-hotkey-overlay; # I am forgetful
          "Mod+Shift+Escape" = {
            # Ensures niri keybinds are read
            action = toggle-keyboard-shortcuts-inhibit;
            allow-inhibiting = false;
          };

          # Session management
          "Ctrl+Alt+Delete".action = quit; # Log out
          #"Mod+Escape".action.spawn = "<lock>"; # Screen lock
          "Mod+Shift+P".action = power-off-monitors; # Power saving

          # Task management
          "Mod+Q".action = close-window;
          "Mod+Q".repeat = false; # No window decorations lol
          "Mod+O".action = toggle-overview;
          "Mod+O".repeat = false; # Multi-tasking
          "Mod+Tab".action = spawn "${pkgs.wofi}/bin/wofi";
          "Mod+Tab".repeat = false; # App launcher

          # Terminal
          "Mod+Return".action = spawn "${pkgs.kitty}/bin/kitty";
          "Mod+Return".repeat = false;
          #"Mod+Shift+Return".action = spawn floating "${pkgs.kitty}/bin/kitty";
          #"Mod+Shift+Return".repeat = false;

          # Keyboard focus controls
          "Mod+H".action = focus-column-left;
          "Mod+L".action = focus-column-right; # VIM binds
          "Mod+J".action = focus-window-or-workspace-down;
          "Mod+K".action = focus-window-or-workspace-up;
          "Mod+Left".action = focus-column-left;
          "Mod+Right".action = focus-column-right; # Regular binds
          "Mod+Down".action = focus-workspace-down;
          "Mod+Up".action = focus-workspace-up;

          # Mouse focus controls
          "Mod+WheelScrollLeft".action = focus-column-left;
          "Mod+WheelScrollLeft".cooldown-ms = 200;
          "Mod+WheelScrollRight".action = focus-column-right;
          "Mod+WheelScrollRight".cooldown-ms = 200;
          "Mod+WheelScrollDown".action = focus-workspace-down;
          "Mod+WheelScrollDown".cooldown-ms = 200;
          "Mod+WheelScrollUp".action = focus-workspace-up;
          "Mod+WheelScrollUp".cooldown-ms = 200;

          # Movement controls
          "Mod+Shift+H".action = move-column-left;
          "Mod+Shift+L".action = move-column-right; # VIM binds
          "Mod+Shift+J".action = move-column-to-workspace-down;
          "Mod+Shift+K".action = move-column-to-workspace-up;
          "Mod+Shift+Left".action = move-column-left;
          "Mod+Shift+Right".action = move-column-right; # Regular binds
          "Mod+Shift+Down".action = move-column-to-workspace-down;
          "Mod+Shift+Up".action = move-column-to-workspace-up;

          # Size controls
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

          # Screen capture
          "Mod+S".action.screenshot = {
            show-pointer = false;
          };
          "Mod+Shift+S".action.screenshot-window = [ ]; # Screenshot
          "Mod+Shift+Alt+S".action.screenshot-screen = {
            show-pointer = true;
          };
          #"Mod+hypothetical+bind".action.screenshot-all-screens = {show-pointer = true;};
          #"Mod+hypothetical+bind".action.record-area = {show-pointer = true;};
          #"Mod+hypothetical+bind".action.record-window = {show-pointer = true;};
          #"Mod+hypothetical+bind".action.record-entire-screen = {show-pointer = true;};
          #"Mod+hypothetical+bind".action.record-all-screens = {show-pointer = true;};
        };
      };
    };
}
