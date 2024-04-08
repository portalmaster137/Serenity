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
    hyprshot
    hyprpicker
    brightnessctl

    ## lib wayland
    xwayland
    wayland-utils
    wayland-protocols

    ## lib
    qt5ct
    libva
    meson

    ## compat
    dconf
    gnome.gnome-themes-extra
    xdg-desktop-portal-gtk
    # xdg-desktop-portal-hyprland
    
  ];

}
