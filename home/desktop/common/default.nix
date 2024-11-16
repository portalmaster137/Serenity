{ self, inputs, outputs, lib, config, pkgs, ... }:

{

  imports = [

  ## Import themes and scripts
  ../../common/themes

  ## Import common desktop configs
  ./hyprcursor.nix
  ./hyprpaper.nix
  ./hyprlock.nix
  ./hypridle.nix
  ./udiskie.nix
  ./wlogout.nix
  ./waybar.nix
  ./dunst.nix
  ./wofi.nix
  
  ## Import individual desktop configs
  ../sway
  ../hypr

  ];

  programs = {

    ## For when bimbo needs to play with platters and cbf to deal with cli
    gnome-disks.enable = true;
    seahorse.enable = true;

    ## Apparently nm-applet has a programs option
    nm-applet = {
      enable = true;
       #indicator = false;
    };

    ## idk something for nautilus
    nautilus-open-any-terminal = {
      enable = true;
      terminal = "kitty";
    };

  };

  services = {
    easyeffects.enable = true;
    network-manager-applet.enable = true;
  };

  home.packages = with pkgs; [

    ## auth/security
    polkit-kde-agent
    hyprpolkitagent
    gnome-keyring
    gnome-secrets
    seahorse

    ## desktop
    swww # Wallpaper daemon
    dconf # GTK settings tweaker
    waybar # Desktop status bar
    blueman # GTK bluetooth manager
    ydotool # Click/Keypress emulator
    wlsunset # Blue light filter
    wlr-randr # Display modesetting
    wl-clipboard # Clipboard service
    appimage-run # Runs appimages
    brightnessctl # Control display brightness
    syncthing-tray # File synchronisation
    networkmanager # Network manager ...
    networkmanagerapplet # Tray applet for networkmanager
    gnome-control-center # GUI system settings
    gnome-power-manager # GUI power and battery stats
    gnome-calculator # GTK calculator
    gnome-calendar # GTK calendar
    gsmartcontrol # GUI for smartctl (smartmontools)
    pavucontrol # Volume control centre
    hyprpicker # Colour picker
    hyprcursor # Cursor, duh
    hypridle # Sleep/idle service
    hyprlock # Screen lock
    hyprshot # Screenshot
    nautilus # GTK File manager
    swayimg # Terminal based image viewer
    zathura # PDF viewer
    gparted # GUI partition editor
    kitty # Terminal emulator
    sushi # Previewer for nautilus

    ## fun
    peaclock # Clock, but terminal
    cmatrix # Terminal, but hacker
    hyfetch # Fetch, but queer


    ## misc, lib, compat
    gnome-themes-extra
    meson
    wlroots
    xwayland
    wayland-utils
    wayland-protocols
    libsForQt5.qt5ct
    libnotify
    libva
     #gitwatch
  ];

}
