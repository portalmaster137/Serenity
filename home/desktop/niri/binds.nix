{ config, pkgs, ... }: {

  ## Goals:
  ## - Way to open new windows in specific areas of the creen
  ## - Way to spawn terminals floating 
  ## - Interact with Noctalia shell more with binds

  programs.niri.settings.binds = with config.lib.niri.actions; {



    ## Window manager controls

    # Debug & Utility
    "Mod+Shift+Slash".action = show-hotkey-overlay; # I am forgetful
    "Mod+Shift+Escape" = { # Ensures niri keybinds are read
      action = toggle-keyboard-shortcuts-inhibit;
      allow-inhibiting = false; 
    };

    # Session management
    "Ctrl+Alt+Delete".action = quit; # Log out
    "Mod+Escape".action.spawn = "hyprlock"; # Screen lock
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
    "Mod+Minus".action = set-column-width "-10%";
    "Mod+Equal".action = set-column-width "+10%";
    "Mod+Shift+Minus".action = set-window-height "-10%";
    "Mod+Shift+Equal".action = set-window-height "+10%";
    "Mod+C".action = center-visible-columns;
    "Mod+F".action = maximize-column;
    "Mod+Shift+F".action = fullscreen-window;
    "Mod+Ctrl+F".action = expand-column-to-available-width;
    "Mod+Space".action = toggle-window-floating;
    "Mod+Shift+Space".action = switch-focus-between-floating-and-tiling;

    # Screen capture
    "Mod+S".action.screenshot = {show-pointer = false;};
    "Mod+Shift+S".action.screenshot-window = []; # Screenshot
    "Mod+Shift+Alt+S".action.screenshot-screen = {show-pointer = true;};
    #"Mod+hypothetical+bind".action.screenshot-all-screens = {show-pointer = true;};
    #"Mod+hypothetical+bind".action.record-area = {show-pointer = true;};
    #"Mod+hypothetical+bind".action.record-window = {show-pointer = true;};
    #"Mod+hypothetical+bind".action.record-entire-screen = {show-pointer = true;};
    #"Mod+hypothetical+bind".action.record-all-screens = {show-pointer = true;};
  };
}
