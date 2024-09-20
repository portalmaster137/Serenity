{
  self,
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

  imports = [

  ./git.nix  
  ./yazi.nix
  ./kitty.nix
  ./neofetch.nix

   #../sway
  ../hypr
  
  ];

  home = {

    packages = with pkgs; [

      ## Desktop Environment
      gnome-keyring # GTK keyring for login/sudo/ssh/gpg prompts
      opentabletdriver # Driver for art tablets
      gnome-calculator # Quick maths
      syncthing-tray # File synchronisation
      gnome-calendar # GTK Calendar
      gnome-secrets # GTK application for interaction with password vault
      appimage-run # Runs appimages
      thunderbird # Email client
       #qt5-wayland # Unsure
       #qt6-wayland # Unsure
      pavucontrol # Pulse audio volume contrl
      image-roll # Image viewer
      obsidian # Note-taking
      nautilus # GTK file manager
      peaclock # Clock but terminal
      ydotool # Click/Keypress emulator
      cmatrix # For r/unixporn
      hyfetch # Fetch, but queer
      zathura # PDF viewer
      swayimg # Image viewer
      kitty # Terminal emulator
      micro # Text editor
      btop # System resources
      eog # Image viewer

      ## Games
      osu-lazer-bin # Rhythm is just a click away!
       #steam # What ???

      ## Chat & Web
      lagrange # Browser for the gemini protocol
      vesktop # Modded discord wrapper
      fractal # GTK matrix client - need to fix gnome-keyring
      tor # The Onion Router

      ## Media
      lollypop # GTK music player
       #spotify # Corpo music streaming
      pragha # Music player
      tauon # Music player

      transmission-gtk4 # Torrent client
      nicotine-plus # P2P Media sharing
      jellyfin # Self-Hosted media streaming
      syncplay # Synchronise local playback with friends
      vlc # Multimedia player

      ## Media Creation
      neural-amp-modeler-lv2 # Guitar amp emulator
      bespokesynth # Modular synthesiser and sequencer
      easyeffects # EQ and audio effects
      metronome # A metronome
      vcv-rack # Analogue-Synth emulator
      cardinal # VCV Rack but open source and as a plugin
      audacity # Audio editing
      helvum # GTK patchbay
      ardour # Digital Audio Workstation

      obs-studio # Screen sharing
      inkscape # Vector image editing
      shotcut # Video editing
      blender # 3D modelling
      gimp # Digital image editing

    ];

    stateVersion = "23.11";

  };

  programs = {

    home-manager.enable = true;

     #steam.enable = true; # Apparently steam doesnt exist in home-manager? :thonk:

    fish.enable = true;

    git.enable = true;

    firefox.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;  
    };
  };

  services = {

    kdeconnect = {
      enable = true;
      indicator = true;
    };

    gnome-keyring = {
      enable = true;
       #components = [ ];
    };

  };

  systemd.user.startServices = "sd-switch";

}
