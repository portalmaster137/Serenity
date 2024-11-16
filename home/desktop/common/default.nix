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

  xdg = {
    portal = {
      enable = false;
      xdgOpenUsePortal = false;
      config = {
	common."org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        common.default = [ "gtk" "gnome" ];
        sway.default = [ "gtk" "gnome" ];
        hyprland.default = [ "hyprland" "gtk" "gnome" ];
      };
      configPackages = with pkgs; [
         #xdg-desktop-portal
         #xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
        xdg-desktop-portal-hyprland
      ];
      extraPortals = with pkgs; [
         #xdg-desktop-portal
         #xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
        xdg-desktop-portal-hyprland
      ];
    };
     #userDirs = {
       #extraConfig = {
         #XDG_FLAKE_DIR = "${config.home.homeDirectory}/flakes/nixdots";
	 #XDG_SYNC_DIR = "${config.home.homeDirectory}/Sync";
       #};
     #};
  };

  programs = {
    ## For when bimbo needs to play with platters and cbf to deal with cli
    gnome-disks.enable = true;
    ## GTK secrets management
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
    ## Daemon for easyeffects
    easyeffects.enable = true;
    ## GTK keyring for password prompts
    gnome-keyring.enable = true;
    ## Another method to enable nm-applet
    network-manager-applet.enable = true;
    ## Mobile <-> desktop interaction
    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };

  home = {

    pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 12;
    };

    sessionVariables.GTK_THEME = "Adwaita-dark";

    packages = with pkgs; [
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
  };

  nix.gc = {
    automatic = true;
    frequency = "daily";
    options = "--delete-older-than 1d";
  };

}
