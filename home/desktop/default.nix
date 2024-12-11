{ config, pkgs, lib, ... }:

{

  imports = [

    ## Import common desktop configs
    ./hyprcursor.nix
    ./hyprlock.nix
    #./keybinds.nix
    ./xdg-mime.nix
    ./wlogout.nix
    ./waybar.nix
    ./dunst.nix
    ./wofi.nix
    ./sway.nix

    ## Import misc. desktop configs
    ../scripts/automount
    ../scripts

  ];

  xdg = {
    mime = {
      enable = true;
    };
    mimeApps = {
      enable = true;
      #associations.added = associations;
      #defaultApplications = associations;
    };
    portal = {
      enable = false;
      xdgOpenUsePortal = false;
      config = {
        common."org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        common.default = [ "gtk" "gnome" ];
        #sway.default = [ "gtk" "gnome" ];
        hyprland.default = [ "hyprland" "gtk" "gnome" ];
      };
      configPackages = with pkgs; [
        #xdg-desktop-portal
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
        xdg-desktop-portal-hyprland
      ];
      extraPortals = with pkgs; [
        #xdg-desktop-portal
        xdg-desktop-portal-wlr
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

  fonts = { fontconfig = { enable = true; }; };

  qt = {
    enable = true;
    platformTheme.name = "Adwaita-dark";
    style = {
      name = "Adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  gtk = {
    enable = true;
    theme = lib.mkForce {
      name = "adwaita-dark";
      package = pkgs.adw-gtk3;
    };
    font = {
      name = "${config.theme.font}";
      size = 10;
    };
    iconTheme = {
      package = pkgs.flat-remix-icon-theme;
      name = "Flat-Remix-Grey-Darkest";
    };
    gtk3.extraConfig = { gtk-application-prefer-dark-theme = 1; };
    gtk4.extraConfig = { gtk-application-prefer-dark-theme = 1; };
  };

  #dconf = {
  #enable = true;
  #settings = {
  #  "org/gnome/desktop/interface" = {
  #    gtk-theme = "Adwaita-dark";
  #  	 color-scheme = "prefer-dark";
  #  };
  #};
  #};

  home = {

    pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 12;
    };

    sessionVariables = {
      GTK_THEME = "Adwaita-dark";
      BROWSER = "firefox";
      TERMINAL = "kitty";
      NIXPKGS_ALLOW_UNFREE = 1;
    };

    packages = with pkgs; [
      ## auth/security
      polkit-kde-agent # KDE native polkit agent
      hyprpolkitagent # Hyprland native polkit agent
      gnome-keyring # Keyring for login prompts
      gnome-secrets # GTK password manager
      seahorse # GTK secrets managment
      soteria # GTK/rust desktop-agnostic polkit agent

      ## desktop
      swww # Wallpaper daemon
      dconf # GTK settings tweaker
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

  programs = {

    ## CLI fuzzy find
    fzf = {
      enable = true;
      enableFishIntegration = true;
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

  nix.gc = {
    automatic = true;
    frequency = "daily";
    options = "--delete-older-than 1d";
  };

}
