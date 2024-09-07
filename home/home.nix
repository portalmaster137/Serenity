{ 
  inputs,
  outputs,
  lib,
  config,
  pkgs, 
  ...
}: {

  imports = [
    ./hyprland
    ./git.nix
    ./kitty.nix
    # ./starship.nix
    ./neofetch.nix
    ./scripts/anotherhadi
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
      image-roll
      gnome.eog
      peaclock
      hyfetch
      cmatrix
      kitty
      micro
      btop

      ## multimedia & games
      neural-amp-modeler-lv2
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
      audacity
      jellyfin
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
      discord
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
      # components = [
      # ];
    };

  };
  
  systemd.user.startServices = "sd-switch";

}
