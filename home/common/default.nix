{ self, inputs, outputs, lib, config, pkgs, ... }: 

{

  imports = [
    ./systemd-services
    ./programs
    ../sway
    ../hypr
  ];

  home = {

    packages = with pkgs; [

      ## Desktop Environment
      opentabletdriver # Driver for art tablets
       #gnome-calculator # Quick maths
      syncthing-tray # File synchronisation
       #gnome-calendar # GTK Calendar
      gnome-secrets # GTK password vault manager
      gnome-keyring # GTK login keyring
      dconf-editor # For editing dconf settings graphically
      appimage-run # Runs appimages
       #thunderbird # Email client - commented out due to network issues trying to build it ?
       #qt5-wayland # Unsure
       #qt6-wayland # Unsure
       #pavucontrol # Pulse audio volume contrl
       #image-roll # Image viewer
      obsidian # Note-taking
      nautilus # GTK file manager
       #peaclock # Clock but terminal
      ydotool # Click/Keypress emulator
      cmatrix # For r/unixporn
      hyfetch # Fetch, but queer
      zathura # PDF viewer
      swayimg # Image viewer
      kitty # Terminal emulator
       #micro # Text editor
      piper # mouse configuration
      fish # Apparently I broke it lol ?
       #btop # System resources
       #eog # Image viewer

      ## Games
      osu-lazer-bin # Rhythm is just a click away!
      cockatrice # Magical the gathering but free
      vassal # fossy board-game sim :3
       #steam # What ???

      ## Chat & Web
       #lagrange # Browser for the gemini protocol
      vesktop # Modded discord wrapper
       #fractal # GTK matrix client - need to fix gnome-keyring
       #tor # The Onion Router

      ## Media
       #lollypop # GTK music player
      spotify # Corpo music streaming
       #pragha # Music player
       #tauon # Music player

      transmission_4-gtk # Torrent client
      nicotine-plus # P2P Media sharing
       #jellyfin # Self-Hosted media streaming
       #syncplay # Synchronise local playback with friends
      vlc # Multimedia player

      ## Media Creation
       #neural-amp-modeler-lv2 # Guitar amp emulator
      bespokesynth # Modular synthesiser and sequencer
      easyeffects # EQ and audio effects
      metronome # A metronome
       #vcv-rack # Analogue-Synth emulator
       #cardinal # VCV Rack but open source and as a plugin
      audacity # Audio editing
      helvum # GTK patchbay
      ardour # Digital Audio Workstation

      obs-studio # Screen sharing
       #inkscape # Vector image editing
       #shotcut # Video editing
       #blender # 3D modelling
      gimp # Digital image editing

      ## Misc.

    ];

    stateVersion = "23.11";

  };

  programs = {

    home-manager.enable = true; # Declarative dots

    firefox.enable = true; # Browser of choice

    neovim = { # Zoomer text editor
      enable = true;
      defaultEditor = true; # Default but keeping micro around
    };

    btop = {
      enable = true;
      settings = {
        color_theme = "kyli0x";
        theme_background = false;
      };
    };
    
    dconf = {
      enable = true;
    };

  };

  services = {

    kdeconnect = { # Mobile <-> Desktop interaction
      enable = true;
      indicator = true;
    };

    gnome-keyring = { # GTK keyring for login/sudo/ssh/gpg prompts
      enable = true;
       #components = [ ];
    };

  };

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
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    font = {
      name = config.theme.font;
      size = 10;
    };
    iconTheme = {
      package = pkgs.flat-remix-icon-theme;
      name = "Flat-Remix-Grey-Darkest";
    };

    gtk3.extraConfig = {
      settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

  };

  dconf = {
    settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "Adwaita-dark";
	color-scheme = "prefer-dark";
      };
    };
  };

  home.sessionVariables.GTK_THEME = "Adwaita-dark";

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 12;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
       #xdg-desktop-portal-wlr
      xdg-desktop-portal-gnome
      xdg-desktop-portal-hyprland
    ];
    configPackages = with pkgs; [
      xdg-desktop-portal-gtk
       #xdg-desktop-portal-wlr
      xdg-desktop-portal-gnome
      xdg-desktop-portal-hyprland
    ];
  };

  systemd.user.startServices = "sd-switch";

}
