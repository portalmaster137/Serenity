{
  pkgs,
  variables,
  xkb,
}:
with variables.base32Theme;
''
  ########################################
  ##### devices
  ########################################
  input type:touchpad {
    tap enabled
    natural_scroll enabled
    tap_button_map lrm
    middle_emulation enabled
    drag enabled
  }

  output eDP-1 {
    pos 0 0
  }

  output DP-1 {
    pos 0 1080
  }

  input 1:1:AT_Translated_Set_2_keyboard {
    xkb_layout ${xkb.layout},us
    xkb_variant ${xkb.variant},
  }

''
+ ''
  ########################################
  ##### colors & theme
  ########################################
  # <colorclass>          <border> <background> <text> <indicator> <child_border>
  client.background       #${base00-hex}
  client.focused          #${variables.accent-hex} #${base00-hex} #${base05-hex} #${variables.accent-hex} #${variables.accent-hex}
  client.focused_inactive #${base00-hex} #${base00-hex} #${base04-hex} #${base00-hex} #${base00-hex}
  client.placeholder      #${base00-hex} #${base00-hex} #${base04-hex} #${base00-hex} #${base00-hex}
  client.unfocused        #${base00-hex} #${base00-hex} #${base04-hex} #${base00-hex} #${base00-hex}
  client.urgent           #${base0F-hex} #${base00-hex} #${base05-hex} #${base0F-hex} #${base0F-hex}

  # font
  font pango:sans-serif ${toString variables.font.sans-serif.size}

  # gaps
  gaps outer 0
  gaps inner ${toString variables.gaps}

  # border
  default_border pixel ${toString variables.border-width}
  for_window [class=".+"] border pixel ${toString variables.border-width}
  hide_edge_borders none
  corner_radius ${toString variables.border-radius}
''

+ ''
  ########################################
  ##### window rules
  ########################################
  # inhibit idle when fullscreen
  for_window [app_id=".*"] inhibit_idle fullscreen
  for_window [class=".*"] inhibit_idle fullscreen
  # various floaters
  for_window [window_role="Preferences"] floating enable
  for_window [window_role="bubble"] floating enable
  for_window [window_role="pop-up"] floating enable
  for_window [window_role="task_dialog"] floating enable
  for_window [window_type="dialog"] floating enable
  for_window [window_type="menu"] floating enable
  # apps
  for_window [app_id="flameshot"] border pixel 0, floating enable, fullscreen disable, move absolute position 0 0
  for_window [app_id="org.keepassxc.KeePassXC"] floating enable, sticky enable
''
+ ''
  ########################################
  ##### Bar config
  ########################################
  bar {
    status_command ${pkgs.i3status-rust}/bin/i3status-rs /etc/xdg/sway/i3status-rust.toml
    colors {
        background         #00000000
        focused_workspace  #00000000 #${variables.accent-hex}   #${base05-hex}
        active_workspace   #00000000 #${variables.accent-bg-hex}   #${base05-hex}
        inactive_workspace #00000000 #00000000 #${base05-hex}
        urgent_workspace   #00000000 #${base0F-hex}   #${base05-hex}
    }
    bindsym button2 exec ${pkgs.rofi}/bin/rofi -show drun
    bindsym button5 exec ${pkgs.writeShellScript "nextworkspace" ''
      swaymsg workspace "$(
        swaymsg -t get_workspaces | jq ".[] | select(.focused == true) | (.num + 1)"
      )"
    ''}
  }
''
+ ''
  ########################################
  ##### autostart
  ########################################
  exec --no-startup-id ${pkgs.wpaperd}/bin/wpaperd
  exec --no-startup-id ${pkgs.keepassxc}/bin/keepassxc

  # start sway target (!!)
  exec_always --no-startup-id ${pkgs.writeShellScript "systemd-sway" ''
    ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY I3SOCK SWAYSOCK XDG_CURRENT_DESKTOP PATH
    ${pkgs.systemd}/bin/systemctl --user import-environment DISPLAY WAYLAND_DISPLAY I3SOCK SWAYSOCK XDG_CURRENT_DESKTOP PATH
    ${pkgs.systemd}/bin/systemctl --user start sway.target
  ''}
  exec_always --no-startup-id ${
    pkgs.writeShellScript "configure-gtk" (
      with variables;
      ''
        export XDG_DATA_DIRS=${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:$XDG_DATA_DIRS
        gsettings set org.gnome.desktop.interface color-scheme "prefer-${theme-type}"
        gsettings set org.gnome.desktop.interface cursor-size ${toString theme-cursor-size}
        gsettings set org.gnome.desktop.interface cursor-theme "${theme-cursor}"
        gsettings set org.gnome.desktop.interface font-name "sans-serif ${toString font.sans-serif.size}"
        gsettings set org.gnome.desktop.interface gtk-theme "${theme-gtk}"
        gsettings set org.gnome.desktop.interface icon-theme "${theme-icon}"
        gsettings set org.gnome.desktop.interface monospace-font-name "monospace ${toString font.monospace.size}"
        gsettings set org.gnome.desktop.wm.preferences button-layout "icon:"
      ''
    )
  }

''
