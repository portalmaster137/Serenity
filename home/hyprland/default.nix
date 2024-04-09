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

  ./theme

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

    ## lib wayland
    xwayland
    wayland-utils
    wayland-protocols

    ## lib
    meson
    qt5ct
    libva
    libnotify

    ## compat
    dconf
    gnome.gnome-themes-extra
    xdg-desktop-portal-gtk
    # xdg-desktop-portal-hyprland
    
  ];

}
