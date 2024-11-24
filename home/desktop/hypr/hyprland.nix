{
  self,
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

  imports = [
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland; 
    systemd = {
      enable = true;
      variables = [
        "--all"
      ];
    };
    xwayland.enable = true;

    plugins = [
       #inputs.hyprland-plugins.packages."${pkgs.system}".borders-plus-plus
       #inputs.hyprland-plugins.packages."${pkgs.system}".hyprbars
    ];

       #monitor = desc:Acer Technologies Acer XR341CK 0x5457BEF2, preferred, 0x0, 1
       #monitor = desc:BNQ BenQ G2400W 83805696SL0, preferred, 3440x180, 1

    extraConfig = ''

      monitor = , preferred, auto, auto

    '';

    settings = {
      "$mod" = "SUPER";
      "$shiftMod" = "SUPER_SHIFT";

      exec-once = [
        "startup"
         #"otd-gui"
	       #"${pkgs.udiskie}/bin/udiskie"
         #"${pkgs.hypridle}/bin/hypridle"
         #"${pkgs.swww}/bin/swww swww init"
        "${pkgs.kitty}/bin/kitty --class floating"
        "${pkgs.kitty}/bin/kitty btop"
         #"${pkgs.kitty}/bin/kitty --class yazi yazi"
         #"${pkgs.steam}/bin/steam"
         #"${pkgs.helvum}/bin/helvum"
         #"${pkgs.spotify}/bin/spotify"
         #"${pkgs.vesktop}/bin/vesktop"
         #"${pkgs.easyeffects}/bin/easyeffects --class floating"
      ];

      bind = [
        "$mod, RETURN, exec, ${pkgs.kitty}/bin/kitty"
        "$shiftMod, RETURN, exec, ${pkgs.kitty}/bin/kitty --class floating"
        "$mod, E, exec, ${pkgs.kitty}/bin/kitty yazi"
        "$mod, B, exec, ${pkgs.firefox}/bin/firefox"
        "$mod, C, exec, ${pkgs.kitty}/bin/kitty --class peaclock peaclock"
        "$mod, L, exec, ${pkgs.hyprlock}/bin/hyprlock"
        "$mod, X, exec, powermenu"
        "$mod, SPACE, exec, menu"
        # Windows control
        #"$mod, TAB, layoutmsg, togglesplit"
        "$mod, A, layoutmsg, swapwithmaster master"
        "$mod, Z, layoutmsg, cyclenext"
        "$shiftMod, Z, layoutmsg, rollnext"
        "$mod, Q, killactive,"
        "$mod, T, togglefloating,"
        "$mod, F, fullscreen"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        # Screenshots
        "$shiftMod, PRINT, exec, screenshot window"
        ", PRINT, exec, screenshot monitor"
        "$mod, PRINT, exec, screenshot region"
        "ALT, PRINT, exec, screenshot region swappy"
        # Night Shift
        "$mod, F2, exec, night-shift-off"
        "$mod, F3, exec, night-shift-on"
        # Sound output
        "$mod, F5, exec, ${pkgs.kitty}/bin/kitty --class floating fish -c sound-output"
        "$mod, F6, exec, ${pkgs.kitty}/bin/kitty --class floating fish -c sound-output"
        "$mod, F7, exec, ${pkgs.kitty}/bin/kitty --class floating fish -c sound-output"
      ] ++ (builtins.concatLists (builtins.genList (i:
        let ws = i + 1;
        in [
          "$mod, code:1${toString i}, workspace, ${toString ws}"
          "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
        ]) 9));

      bindm = [ "$mod, R, movewindow" "$shiftMod, R, resizewindow" ];

      bindl = [
        ",XF86AudioMute, exec, sound-toggle"
        ",switch:Lid Switch, exec, ${pkgs.hyprlock}/bin/hyprlock"
      ];

      bindle = [
        ", XF86AudioRaiseVolume, exec, sound-up"
        ", XF86AudioLowerVolume, exec, sound-down"
        ", XF86MonBrightnessUp, exec, brightness-up"
        ", XF86MonBrightnessDown, exec, brightness-down"
      ];

      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "GDK_BACKEND,wayland,x11,*"
	"NIXOS_OZONE_WL,1" # disable if you(g.)'re having issues w/ firefox
	"OZONE_PLATFORM,wayland"
        "SDL_VIDEODRIVER,wayland,x11"
	"WLR_RENDERER_ALLOW_SOFTWARE,1"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "GTK_THEME,adwaita-dark"
         #"HYPRCURSOR_THEME,rose-pine"
         #"HYPRCURSOR_SIZE,16"
         #"XCURSOR_THEME,rose-pine"
         #"XCURSOR_SIZE,16"
	"NIXPKGS_ALLOW_UNFREE,1"
      ];

      general = {
        resize_on_border = true;
        gaps_in = config.theme.gaps-in;
        gaps_out = config.theme.gaps-out;
        border_size = config.theme.border-size;
        "col.active_border" = "rgba(${config.theme.colors.primary-bg}ff)";
        "col.inactive_border" = "rgba(00000055)";
        border_part_of_window = true;
        layout = "dwindle";
      };

      decoration = {
        rounding = config.theme.rounding;
	shadow = {
          enabled = true;
          range = 25;
          render_power = 3;
          color = "rgba(00000055)";
	};
        blur = { enabled = true; };
      };

      #master = {
        #mfact = 0.4;
        #orientation = "center";
        #always_center_master = true;
        #new_is_master = true;
        #new_on_top = false;
      #};

      dwindle = {
      	pseudotile = true;
      	preserve_split = true;
      	force_split = 2;
      };

      gestures = { workspace_swipe = true; };

      misc = {
        disable_hyprland_logo = false;
        disable_splash_rendering = true;
        focus_on_activate = true;
        new_window_takes_over_fullscreen = 2;
      };

      input = {
        kb_layout = "us";

        kb_options = "caps:escape";
        follow_mouse = 1;
        sensitivity = 0.1;
        repeat_delay = 350;
        repeat_rate = 40;
        numlock_by_default = true;

        touchpad = {
          natural_scroll = true;
          clickfinger_behavior = true;
        };
      };

      windowrulev2 = [
        "float, class:peaclock"
        "move 2% 78%, class:peaclock"
        "size 30% 20%, class:peaclock"

        "float, class:floating"
        "size 40% 40%, class:floating"
        "move 30% 30%, class:floating"

        "float, title:Bluetooth Devices"
        "move 20% 20%, title:Bluetooth Devices"
        "size 60% 60%, title:Bluetooth Devices"
      ];

      animations = {
        enabled = true;
        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92 "
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "fluent_decel, 0.1, 1, 0, 1"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
        ];

        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 2.5, md3_decel"
          "workspaces, 1, 3.5, easeOutExpo, slide"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };

    };
  };

}
