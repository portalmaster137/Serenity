{ pkgs, ... }:

let

  increments = "5";

  menu = pkgs.writeShellScriptBin "menu" ''
    if pgrep wofi; then
    	pkill wofi
    else
    	${pkgs.wofi}/bin/wofi --show drun
    fi
  '';

  powermenu = pkgs.writeShellScriptBin "powermenu" ''
    if pgrep wlogout; then
    	pkill wlogout
    else
      ${pkgs.wlogout}/bin/wlogout
    fi
  '';

  brightness-up = pkgs.writeShellScriptBin "brightness-up" ''
    brightness-change up ${increments}
  '';

  brightness-down = pkgs.writeShellScriptBin "brightness-down" ''
    brightness-change down ${increments}
  '';

  brightness-change = pkgs.writeShellScriptBin "brightness-change" ''
    sleep 0.05

    [[ $1 == "up" ]] && ${pkgs.brightnessctl}/bin/brightnessctl set ${increments}%+
    [[ $1 == "down" ]] && ${pkgs.brightnessctl}/bin/brightnessctl set ${increments}%-

    brightness_level=$(${pkgs.brightnessctl}/bin/brightnessctl get)

    message="󰃠  Brightness: $brightness_level%"

    ${pkgs.libnotify}/bin/notify-send "$message" \
                -h int:value:"$brightness_level" \
                --replace-id="$(cat "/tmp/nixy-notification" 2>/dev/null || echo 0)" --print-id > "/tmp/nixy-notification"
  '';

  screenshot = pkgs.writeShellScriptBin "screenshot" ''
    if [[ $2 == "swappy" ]];then
      folder="/tmp"
    else
      folder="$HOME/Pictures/screenshots"
    fi
    filename="$(date +%Y-%m-%d_%H:%M:%S).png"
    mode="region" # Default to region

    if [[ $1 == "window" ]];then
      mode="window"
    elif [[ $1 == "monitor" ]];then
      mode="output"
    fi

    ${pkgs.hyprshot}/bin/hyprshot -m $mode -o $folder -f $filename -s || exit 1

    if [[ $2 == "swappy" ]];then
      ${pkgs.swappy}/bin/swappy -f "$folder/$filename" -o "$HOME/Pictures/screenshots/$filename"
      exit 0
    fi

    message="  Screenshot saved"

    ${pkgs.libnotify}/bin/notify-send "$message" \
                --icon="$folder/$filename" \
                --replace-id="$(cat "/tmp/nixy-notification" 2>/dev/null || echo 0)" --print-id > "/tmp/nixy-notification"
  '';

  vault = pkgs.writeShellScriptBin "vault" ''
    nvim $HOME/Nextcloud/obsidian
  '';

in {
  home.packages = with pkgs; [
    menu
    powermenu
    brightness-up
    brightness-down
    brightness-change
    screenshot
    hyprshot
    vault
  ];

}
