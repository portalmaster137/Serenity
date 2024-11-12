{ self, inputs, outputs, lib, config, pkgs, ... }:

{

  imports = [

  ## Import themes and scripts
  ../common/themes
  ../common/scripts

  ## Import common desktop configs
  ./hyprcursor.nix
  ./hyprpaper.nix
  ./hyprlock.nix
  ./hypridle.nix
  ./wlogout.nix
  ./waybar.nix
  ./dunst.nix
  ./wofi.nix
  
  ## Import individual desktop configs
  ./sway
  ./hypr

  ];

  programs = {
    ## To run "normal" linux applications seamlessly
    appimage = {
      enable = true;
      binfmt = true;
    };
  };

  home.packages = with pkgs; [

    ## desktop environment
    swww
     #fish # maybe broken?
    kitty # Terminal emulator
    waybar
    ydotool # Click/Keypress emulator
    zathura # PDF viewer
    swayimg # Image viewer
    cmatrix # For r/unixporn
    hyfetch # Fetch, but queer
     #peaclock # Clock but terminal
    wlroots
    wlsunset
    wlr-randr
    wl-clipboard
    appimage-run # Runs appimages
    brightnessctl
    syncthing-tray # File synchronisation
    networkmanagerapplet
    hyprpolkitagent
    hyprpicker
    hyprcursor
    hypridle
    hyprlock
    hyprshot

    ## gnome stuff
    dconf
    seahorse
    nautilus # GTK file manager
    gnome-keyring # GTK login keyring
    gnome-secrets # GTK password vault manager
    gnome-calendar # GTK Calendar
    gnome-calculator # Quick maths
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
