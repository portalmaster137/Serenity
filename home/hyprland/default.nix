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
    hyprshot
    hyprpicker
    # xdg-desktop-portal-hyprland
    wlr-randr
    wl-clipboard
    brightnessctl
    gnome.gnome-themes-extra
    wlsunset
    xwayland
    xdg-desktop-portal-gtk
    wlroots
    qt5ct
    libva
    dconf
    wayland-utils
    wayland-protocols
    meson
    waybar
  	swww
  ];

}
