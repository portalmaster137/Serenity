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
    ./qutebrowser
  ];

  home = {

    packages = with pkgs; [

      ## desktop environment
      gnome.gnome-keyring
      opentabletdriver
      syncthing-tray
      gnome.nautilus
      gnome-secrets
      appimage-run
      # qt5-wayland
      # qt6-wayland
      peaclock
      hyfetch
      cmatrix
      kitty
      micro

      ## multimedia & games
      nicotine-plus
      osu-lazer-bin
      easyeffects
      obs-studio
      inkscape
      obsidian
      spotify
      helvum
      ardour
      steam # (needs config via home.programs.steam)
      gimp

      ## chat & web
      # schildichat
      lagrange
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

    gvfs.enable = true;

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
