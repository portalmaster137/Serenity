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

  ./hyprcursor.nix
  ./wlogout.nix
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
    hyprlock
    hyprshot
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

    meson
    qt5ct
    libva
    libnotify
    dconf
    xwayland
    wayland-utils
    wayland-protocols
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    
  ];

}
