{ inputs, config, pkgs, lib, flakePath, homeDirectory, ... }:

## Base desktop theme
let

  #serenityos-base = import ./serenityos-base.nix { inherit pkgs; };
  #line-icons = import ./line-icons.nix { inherit pkgs; };

in {

  imports = [

    #inputs.niri.homeModules.niri

    ## Import common desktop configs
    ./xdg-mime.nix # file associations
    ./hyprcursor.nix # mouse cursor
    ./hyprlock.nix # screen locker
    ./dunst.nix # notifier
    ./wofi.nix # launcher
    ./niri # WM
    #./sway # WM
    #./noctalia.nix # Desktop shell

  ];

  systemd.user.startServices = "sd-switch"; # cant remember

  xdg = {
   
    #configFile."niri/config.kdl".source = ./niri.kdl;

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
        XDG_SYNC_DIR = "${homeDirectory}/Sync";
      };
    };
  };

  fonts = { fontconfig = { enable = true; }; };

  qt = {
    enable = true;
    #platformTheme.name = "Colloid-dark";
    #style = {
    #name = "Colloid-dark";
    #package = pkgs.colloid-kde;
    #};
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
      ## Network & Auth/Security
      #networkmanagerapplet # Tray applet for networkmanager 
      hyprpolkitagent # Hyprland native polkit agent
      networkmanager # Network manager ...
      gnome-keyring # Keyring for login prompts
      gnome-secrets # GTK password manager
      keepass-diff # CLI-tool to diff kbdx files
      keepassxc # Feature rich password manager
      seahorse # GTK secrets managment
      soteria # GTK/rust desktop-agnostic polkit agent

      ## Desktop
      brightnessctl # Display brightness control
      wdisplays # Display configuration
      wlr-randr # Display modesetting
      wlsunset # Bluelight filter
      hyprlock # Screen lock
      wl-clipboard # Clipboard service
      hyprpicker # Colour picker
      hyprcursor # Cursor, duh
      ydotool # Click/Keypress emulator
      #swww # Wallpaper daemon
      #swaybg # Wallpaper daemon

      ## Desktop App Suite
      gnome-calculator # GTK calculator
      appimage-run # Runs appimages
      file-roller # Archive manager
      #virtualbox # Virtual machine
      nautilus # GTK File manager
      obsidian # Note taking
      swayimg # Terminal based image viewer
      zathura # PDF viewer
      gparted # GUI partition editor

      ## Misc./lib/compat
      wayland-protocols
      wayland-utils
      xwayland
      wlroots
      libsForQt5.qt5ct
      libsForQt5.qt5.qtwayland
      libnotify
      libva
      meson

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
    ## GTK keyring for password prompts
    gnome-keyring.enable = true;
    ## Mobile <-> desktop interaction
    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 1d";
  };

}
