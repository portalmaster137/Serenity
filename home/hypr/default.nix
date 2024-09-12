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
    hyprpaper
    hyprpicker
    hyprcursor
    brightnessctl
    ## gnome stuff
    gnome.sushi
    gnome.seahorse
    networkmanagerapplet
    gnome.gnome-themes-extra
    gnome.gnome-control-center

    ## lib and compat
    xwayland
    wayland-utils
    wayland-protocols
    meson
    qt5ct
    libva
    libnotify
    dconf
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    # xdg-desktop-portal-hyprland
    
  ];

}
