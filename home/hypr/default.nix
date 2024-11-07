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
    waybar
    swww
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
    brightnessctl

    ## gnome stuff
     #sushi
    seahorse
    networkmanagerapplet
    gnome-themes-extra

    ## lib and compat
    xwayland
    wayland-utils
    wayland-protocols
    meson
    libsForQt5.qt5ct
    libva
    libnotify
    dconf
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    xdg-desktop-portal-hyprland
    
  ];

}
