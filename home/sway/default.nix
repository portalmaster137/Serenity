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

  ./sway.nix

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
