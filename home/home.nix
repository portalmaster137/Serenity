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
    # ./qutebrowser
  ];

  home = {

    packages = with pkgs; [

  	  ## desktop environment
      opentabletdriver
      gnome.nautilus
  	  appimage-run
  	  # qt5-wayland
  	  # qt6-wayland
      peaclock
      hyfetch
      cmatrix
      kitty
      micro
      glib

      ## audiovisual
      easyeffects
      obs-studio
      inkscape
      helvum
      ardour
      gimp

      ## diary & sync
      syncthing-tray
      gnome-secrets
      obsidian
      vscode

      ## chat & comms
      schildichat
      fractal # fix gnome-keyring 
      discord

	    ## web browsers
	    lagrange
	    firefox
	    tor 

      ## media consumption
      nicotine-plus
      spotify

      ## games
      osu-lazer-bin
      # steam (needs config)

    ];

    stateVersion = "23.11";
  };

  programs = {
    home-manager.enable = true;
    starship.enable = true;
    fish.enable = true;
    git.enable = true;
    firefox.enable = true;
    helix = {
      enable = true;
      defaultEditor = true;
    };
	  kdeconnect = {
	    enable = true;
	    indicator = true;
	  };
  };

  services = {
  	gnome-keyring = {
      enable = true;
  	  components = [
  	  ];
  	};
  };
  
  systemd.user.startServices = "sd-switch";

}
