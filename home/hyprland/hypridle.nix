{ config, pkgs, ... }: {

  xdg.configFile."hypr/hypridle.conf".text = ''
    general {
        ignore_dbus_inhibit = false
    }

    # Screenlock
    listener {
        timeout = 10000
        on-timeout = ${pkgs.hyprlock}/bin/hyprlock
        on-resume = ${pkgs.libnotify}/bin/notify-send "Welcome back ${config.home.username}!"
    }

    # Suspend
    listener {
        timeout = 10000
        on-timeout = systemctl suspend
        # on-resume = ${pkgs.libnotify}/bin/notify-send "Welcome back to your desktop!"
    }
  '';
}
