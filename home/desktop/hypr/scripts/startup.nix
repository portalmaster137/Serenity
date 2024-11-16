# File runned at startup by Hyprland
{ pkgs, config, ... }:
let
  homedir = config.home.homeDirectory;

  battery-notif = pkgs.writeShellScriptBin "battery-notif" ''
    # Send notifications when low on battery and not in charge
    while true; do
      battery_level=$(cat /sys/class/power_supply/BAT*/capacity)
      battery_status=$(cat /sys/class/power_supply/BAT*/status)
      if [[ $battery_level -le 20 ]] && [[ $battery_status == "Discharging" ]]; then
        ${pkgs.libnotify}/bin/notify-send "󰁻  Low battery" "Battery level is $battery_level%"
      elif [[ $battery_level -le 10 ]] && [[ $battery_status == "Discharging" ]]; then
        ${pkgs.libnotify}/bin/notify-send --urgency=critical "󰁺  Very low battery" "Battery level is $battery_level%"
      fi
      sleep 60
    done
  '';

  startup = pkgs.writeShellScriptBin "startup" ''
    # Because HM enabling services suck.

    systemctl --user start sops-nix

    systemctl --user start hyprpolkitagent

    swww-daemon & sleep 0.1

    swww img ~/flakes/nixdots/home/desktop/resources/wallpapers/sphericaEssentia-uncredited.png

  '';

in {
  home.packages = with pkgs; [
    startup
     #battery-notif
  ];
}
