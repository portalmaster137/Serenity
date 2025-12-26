{ config, pkgs, ... }: {
  programs.niri.settings.binds = with config.lib.niri.actions; {

    "Mod+Shift+Slash".action = show-hotkey-overlay;
    "Mod+Return".action = spawn "${pkgs.kitty}/bin/kitty";
    "Mod+Tab".action = spawn "${pkgs.wofi}/bin/wofi";

    "Mod+O" = {
      action = toggle-overview;
      repeat = false;
    };

    "Mod+Q" = {
      action = close-window;
      repeat = false;
    };

    "Mod+Escape".action.spawn = "hyprlock";

    "Mod+Shift+P".action = power-off-monitors;

    "Mod+Shift+E".action = quit;
    "Ctrl+Alt+Delete".action = quit;

    "Mod+Shift+Escape".action = toggle-keyboard-shortcuts-inhibit;
    "Mod+Shift+Escape".allow-inhibiting = false;

    "Mod+C".action = center-visible-columns;
    "Mod+F".action = maximize-column;
    "Mod+Shift+F".action = fullscreen-window;
    "Mod+Ctrl+F".action = expand-column-to-available-width;
    "Mod+Space".action = toggle-window-floating;
    "Mod+Shift+Space".action = switch-focus-between-floating-and-tiling;

    "Mod+Minus".action = set-column-width "-10%";
    "Mod+Plus".action = set-column-width "+10%";
    "Mod+Shift+Minus".action = set-window-height "-10%";
    "Mod+Shift+Plus".action = set-window-height "+10%";

    #"Mod+1".action = set-column-width "25%";
    #"Mod+2".action = set-column-width "50%";
    #"Mod+3".action = set-column-width "75%";
    #"Mod+4".action = set-column-width "100%";

    #"Print".action.screenshot-screen = {write-to-disk = true;};
    #"Mod+Shift+Alt+S".action.screenshot-window = [];
    #"Mod+Shift+S".action.screenshot = {show-pointer = false;};

    #"Mod+WheelScrollUp".action = focus-workspace-up;
    "Mod+WheelScrollUp".cooldown-ms = 200;
    #"Mod+WheelScrollDown".action = focus-workspace-Down;
    "Mod+WheelScrollDown".cooldown-ms = 200;

    "Mod+H".action = focus-column-left;
    "Mod+L".action = focus-column-right;
    "Mod+J".action = focus-window-or-workspace-down;
    "Mod+K".action = focus-window-or-workspace-up;
    "Mod+Left".action = focus-column-left;
    "Mod+Right".action = focus-column-right;
    "Mod+Down".action = focus-window-or-workspace-down;
    "Mod+Up".action = focus-window-or-workspace-up;

    "Mod+Shift+H".action = move-column-left;
    "Mod+Shift+L".action = move-column-right;
    "Mod+Shift+K".action = move-column-to-workspace-up;
    "Mod+Shift+J".action = move-column-to-workspace-down;
    "Mod+Shift+Left".action = move-column-left;
    "Mod+Shift+Right".action = move-column-right;
    "Mod+Shift+Down".action = move-column-to-workspace-down;
    "Mod+Shift+Up".action = move-column-to-workspace-up;

  };
}
