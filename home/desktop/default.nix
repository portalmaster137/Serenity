{ inputs, config, pkgs, lib, flakePath, homeDirectory, ... }:

## Base desktop theme
let

  #serenityos-base = import ./serenityos-base.nix { inherit pkgs; };
  #line-icons = import ./line-icons.nix { inherit pkgs; };

in {

  imports = [

    #inputs.niri.homeModules.niri

    # Import common desktop configs
    ./xdg-mime.nix # file associations
    ./wofi.nix # launcher
    ./niri # WM

    ## IMPORTED ELSEWHERE
    #./niri/noctalia.nix # Desktop shell

    # Import user theme(s)
    ../resources/theme 
    ../resources/theme/SerenityOS.nix
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
    #./sway # WM
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
    gtk3.extraConfig = { 
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = { 
      gtk-application-prefer-dark-theme = 1; 
    };
  };

  home = {

    file.".icons/bibata".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic";

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
      # Network & Auth/Security
      #networkmanagerapplet # Tray applet for networkmanager 
      #networkmanager # Network manager ...
      gnome-keyring # Keyring for login prompts
      gnome-secrets # GTK password manager
      keepass-diff # CLI-tool to diff kbdx files
      keepassxc # Feature rich password manager
      seahorse # GTK secrets managment
      soteria # GTK/rust desktop-agnostic polkit agent

      # Desktop
      brightnessctl # Display brightness control
      wdisplays # Display configuration
      wlr-randr # Display modesetting
      wlsunset # Bluelight filter
      wl-clipboard # Clipboard service

      # Desktop App Suite
      gnome-calculator # GTK calculator
      appimage-run # Runs appimages
      file-roller # Archive manager
      #virtualbox # Virtual machine
      nautilus # GTK File manager
      swayimg # Terminal based image viewer
      zathura # PDF viewer
      gparted # GUI partition editor

      # Misc./lib/compat
      wayland-protocols
      wayland-utils
      xwayland
      wlroots
      libsForQt5.qt5ct
      libsForQt5.qt5.qtwayland
      libnotify
      libva
      meson
      themix-gui # GTK theme creation

    ];
  };

  services = {

    # GTK keyring for password prompts
    gnome-keyring.enable = true;

    # Phone <-> Desktop integration
    kdeconnect = {
      enable = false;
      indicator = true;
    };

    # Syncthing program service
    #syncthing = {
      #enable = false;
      #tray.enable = true;
      #guiAddress = "home.syncthing:8384";
    #};

  # Disk automount service
    udiskie = {
      enable = true;
      automount = true; # automatically mount new disk
      notify = true; # sends notification on disk mount
    };
  };

  ## MOVE TO MORE SENSIBLE SPOT
  #nix.gc = {
    #automatic = true;
    #dates = "daily";
    #options = "--delete-older-than 1d";
  #};

  ## ORGANISE THIS MESS
  # https://mynixos.com/home-manager/options/home.file.%3Cname%3E
  # https://nix-community.github.io/home-manager/options.xhtml#opt-home.file
  # https://nix-community.github.io/home-manager/options.xhtml#opt-home.activation
  # need option for `zfs set mountpoint=/myspecialfolder mypool`
  # need to set up auto luks unlock with sops-nix

  ## Provides LUKS key for Asphodel
  #environment.etc."crypttab".text = ''
  #Asphodel /dev/disk/by-uuid/45f5f6ad-a676-4bc1-ad4b-e3e26b5697f4 ${config.sops.secrets.asphodelLuksPassword}
  #'';

  ## Mounts Asphodel to typical media location
  #fileSystems."/run/media/${user}/Asphodel".device =
  #"/dev/mapper/Asphodel";

  #home.file = { # Files and directories to copy to ${homeDirectory}

  ## Example format for home.file
  #"Foo" = { # Name for the copied file
  #source = ./Foo; # Source is relative to this file
  #target = "Desired/Path/To/Foo"; # Target path for Foo within ${homeDirectory}
  #recursive = true; # Unsure if necessary for most things
  #};

  #};

}
