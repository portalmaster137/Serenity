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

  #./themes

  ./git.nix  
  #./fish.nix
  ./kitty.nix
  #./lazygit.nix
  ./neofetch.nix

  #../sway
  ../hyprland
  
  ];

  home = {

    packages = with pkgs; [

      ## desktop environment
      gnome.gnome-keyring
      opentabletdriver
      # gnome-calculator
      syncthing-tray
      gnome.nautilus
      # gnome-calendar
      gnome-secrets
      appimage-run
      # qt5-wayland
      # qt6-wayland
      # gnome-clocks
      pavucontrol
      image-roll
      gnome.eog
      peaclock
      cmatrix
      hyfetch
      zathura
      kitty
      micro
      btop

      ## multimedia & games
      neural-amp-modeler-lv2
      #evolutionWithPlugins # or
      thunderbird
      transmission-gtk
      nicotine-plus
      osu-lazer-bin
      bespokesynth
      easyeffects
      obs-studio
      metronome
      inkscape
      obsidian
      vcv-rack
      cardinal
      audacity
      jellyfin
      swayimg # or
      #nomacs
      #imv
      clapper
      ydotool # or
      #wtypeswayim
      spotify
      blender
      helvum
      ardour
      steam # (needs config via home.programs.steam)
      gimp
      vlc
      
      ## chat & web
      # schildichat
      lagrange
      vesktop
      #dissent
      #discord
      fractal # fix gnome-keyring 
      tor 
    ];

    stateVersion = "23.11";
    
  };

  programs = {
    home-manager.enable = true;
    starship.enable = true;
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
