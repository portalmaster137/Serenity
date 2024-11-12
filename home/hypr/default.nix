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

  ../common/themes
  ../common/scripts

  ./hyprland.nix  
  ./hyprpaper.nix
  ./hyprcursor.nix
  ./wlogout.nix
  ./hypridle.nix
  ./hyprlock.nix
  ./waybar.nix
  ./dunst.nix
  ./wofi.nix
  
  ];

  home.packages = with pkgs; [

    ## desktop environment
    swww
    waybar
    wlroots
    wlsunset
    wlr-randr
    wl-clipboard
    hypridle
    hyprlock
    hyprshot
     #hyprpaper
    hyprpicker
    hyprcursor
    hyprpolkitagent
    brightnessctl

    ## gnome stuff
     #sushi
    dconf
    seahorse
    networkmanagerapplet
    gnome-themes-extra

    ## lib and compat
    xwayland
    wayland-utils
    wayland-protocols
    meson
    libva
    libnotify
    libsForQt5.qt5ct
  ];

}
