{ config, pkgs, lib, flakePath, homeDir, ... }:

## Base desktop theme
let

  #serenityos-base = import ./serenityos-base.nix { inherit pkgs; };
  #line-icons = import ./line-icons.nix { inherit pkgs; };

in {

  imports = [

    ## Import common desktop configs
    ./xdg-mime.nix # file associations
    ./hyprcursor.nix # mouse cursor
    ./hyprlock.nix # screen locker
    ./wlogout.nix # logout prompt
    ./waybar.nix # statusbar
    ./dunst.nix # notifier
    ./wofi.nix # app menu
    ./sway.nix # desktop
    ../scripts # scripts

  ];

  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = false;
      config = {
        common."org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        common.default = [ "gtk" "wlr" "gnome" ];
        sway.default = [ "gtk" "wlr" "gnome" ];
      };
      configPackages = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gnome
      ];
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gnome
      ];
    };
    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_FLAKE_DIR = "${flakePath}";
        XDG_SYNC_DIR = "${homeDir}/Sync";
      };
    };
  };

  fonts = { fontconfig = { enable = true; }; };

  qt = {
    enable = true;
    platformTheme.name = "Colloid-dark";
    style = {
      name = "Colloid-dark";
      package = pkgs.colloid-kde;
    };
  };

  gtk = {
    enable = true;
    theme = lib.mkForce {
      name = "Colloid-Dark";
      package = pkgs.colloid-gtk-theme;
      #name = "serenityos-base";
      #package = pkgs.serenityos-base;
    };
    font = {
      name = "${config.theme.font}";
      size = 10;
    };
    iconTheme = {
      name = "Flat-Remix-Grey-Darkest";
      package = pkgs.flat-remix-icon-theme;
      #name = "line-icons";
      #package = pkgs.line-icons;
    };
    gtk3.extraConfig = { gtk-application-prefer-dark-theme = 1; };
    gtk4.extraConfig = { gtk-application-prefer-dark-theme = 1; };
  };

  home = {

    file = {
      ".icons/bibata".source =
        "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic";
    };

    pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 12;
    };

    sessionVariables = {
      GTK_THEME = "Colloid-Teal-Dark-Dracula"; # i haev no idea what im doing
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
      networkmanager # Network manager ...
      networkmanagerapplet # Tray applet for networkmanager
      gnome-calculator # GTK calculator
      pavucontrol # Volume control centre
      file-roller # archive manager
      hyprpicker # Colour picker
      hyprcursor # Cursor, duh
      hyprlock # Screen lock
      nautilus # GTK File manager
      swayimg # Terminal based image viewer
      zathura # PDF viewer
      gparted # GUI partition editor
      kitty # Terminal emulator

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

      ## Themes
      colloid-kde
      colloid-gtk-theme
      adapta-gtk-theme
      adapta-kde-theme
      materia-theme
      materia-theme-transparent

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
