{ inputs, config, pkgs, lib, flakePath, homeDirectory, ... }:

let

  # Base desktop theme
  #serenityos-base = import ./serenityos-base.nix { inherit pkgs; };
  #line-icons = import ./line-icons.nix { inherit pkgs; };

in {

  imports = [
    # Import common desktop configs
    ./xdg-mime.nix # file associations
    ./wofi.nix # launcher
    ./niri # WM
    # Import user theme(s)
    ../resources/theme 
    ../resources/theme/SerenityOS.nix
  ];

  # Services
  systemd.user.startServices = "sd-switch"; # cant remember
  services = {
    # GTK keyring for password prompts
    gnome-keyring = {
      enable = true; # enables gnome-keyring
    };
    # Phone <-> Desktop integration
    kdeconnect = {
      enable = false; # enables kdeconnect
      indicator = false; # enables tray applet
    };
    # Disk automount service
    udiskie = {
      enable = true; # enables udiskie
      tray = "always"; # enables tray applet
      notify = true; # sends notification on disk mount
      automount = true; # automatically mount new disk
    };
  };

  xdg = {
    # Creates user directory variables
    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        FLAKE = "${flakePath}";
        SYNC = "${homeDirectory}/Sync";
      };
    };
    # Enables portals
    portal = {
      enable = true;
      xdgOpenUsePortal = false;
      # Extra portal config
      config = {
        common."org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        common.default = [ "gtk" "wlr" "gnome" ];
        sway.default = [ "gtk" "wlr" "gnome" ];
      };
      # Packages to use for config
      configPackages = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gnome
      ];
      # Extra portals to enable
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gnome
      ];
    };
  };

  qt = {
    # Enables QT
    enable = true;
    # Specifies the base theme to use
    #platformTheme.name = "Colloid-dark";
    #style = {
      #name = "Colloid-dark";
      #package = pkgs.colloid-kde;
    #};
  };

  gtk = {
    # Enables GTK
    enable = true;
    # Specifies the font to use
    font = {
      name = "${config.theme.font}";
      size = 10;
    };
    # Specifies the icon theme to use
    iconTheme = {
      name = "Flat-Remix-Grey-Darkest";
      package = pkgs.flat-remix-icon-theme;
    };
    # Specifies the base theme to use
    theme = lib.mkForce {
      name = "Colloid-Dark";
      package = pkgs.colloid-gtk-theme;
    };
    # Tries to force a dark theme globally
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  # Fonts
  # surely there is a better way to do fonts ?
  fonts = { fontconfig = { enable = true; }; };

  home = {
    # Sets user session variables
    sessionVariables = {
      GTK_THEME = "Colloid-Teal-Dark-Dracula"; # i haev no idea what im doing
      BROWSER = "firefox"; # furry browser
      TERMINAL = "kitty"; # furry terminal
      NIXPKGS_ALLOW_UNFREE = 1; # unfortunately
    };
    # Copies cursor theme files to the relevant location
    file.".icons/bibata".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic";
    # Specifies pointer theme and size
    pointerCursor = {
      gtk.enable = true; # GTK cursor
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 12;
    };
    # Base package set to include in home/desktop configuration
    packages = with pkgs; [
      # Networking
      #networkmanagerapplet # Tray applet for networkmanager 
      #networkmanager # Network manager ...
      # Security
      gnome-keyring # Keyring for login prompts
      gnome-secrets # GTK password manager
      keepass-diff # CLI-tool to diff kbdx files
      keepassxc # Feature rich password manager
      seahorse # GTK secrets managment
      soteria # GTK/rust desktop-agnostic polkit agent
      # Desktop Features
      brightnessctl # Display brightness control
      wdisplays # Display configuration
      wlr-randr # Display modesetting
      wlsunset # Bluelight filter
      wl-clipboard # Clipboard service
      # Desktop App Suite
      gnome-calculator # Simple calculator
      appimage-run # Runs appimages
      file-roller # Simple archive manager
      themix-gui # GTK theme creation tool
      nautilus # Simple file manager
      swayimg # Terminal based image viewer
      zathura # Simple PDF viewer
      gparted # GUI partition editor
      # Wayland
      wayland-protocols
      wayland-utils
      xwayland
      wlroots
      # QT
      libsForQt5.qt5.qtwayland 
      libsForQt5.qt5ct
      # Misc.
      libnotify # Notifier library
      libva # Library for ???
      meson # Package builder
    ];
  };

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
    # Syncthing program service
    #syncthing = {
      #enable = false; # enables syncthing
      #tray.enable = true; # enables tray applet
      #guiAddress = "home.syncthing:8384"; # local addess to use
    #};

}
