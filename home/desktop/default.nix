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
      ## Auth/Security
      hyprpolkitagent # Hyprland native polkit agent
      gnome-keyring # Keyring for login prompts
      gnome-secrets # GTK password manager
      keepass-diff # CLI-tool to diff kbdx files
      keepassxc # Feature rich password manager
      seahorse # GTK secrets managment
      soteria # GTK/rust desktop-agnostic polkit agent

      ## Desktop
      brightnessctl # Display brightness control
      wlr-randr # Display modesetting
      wlsunset # Bluelight filter
      hyprlock # Screen lock
      wl-clipboard # Clipboard service
      hyprpicker # Colour picker
      hyprcursor # Cursor, duh
      ydotool # Click/Keypress emulator
      swww # Wallpaper daemon
      networkmanagerapplet # Tray applet for networkmanager
      networkmanager # Network manager ...
      blueman # GUI bluetooth control
      easyeffects # Graphical volume control
      pavucontrol # Graphical volume control
      helvum # GTK patchbay

      ## Desktop App Suite
      gnome-calculator # GTK calculator
      appimage-run # Runs appimages
      file-roller # Archive manager
      virtualbox # Virtual machine
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
