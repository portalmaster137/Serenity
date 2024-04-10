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
  	  ## nixos
  	  appimage-run

      ## desktop
      xfce.thunar
      # gnome.nautilus ?

	  ## web browsers
	  firefox
	  lagrange
	  tor     

      ## chat & comms
      discord
      fractal
      # schildichat

      ## personal 
      obsidian

      ## graphics & art
      gimp
      inkscape
      
      ## terminal & coding
      vscode
	  micro
	  kitty
	  ## utility
	  # insert terminal utility here
      ## novelty
      pipes
      cbonsai
      hyfetch
      cmatrix
      peaclock

  	  ## misc, libraries, maybe more,
  	  # qt5-wayland
  	  # qt6-wayland
  	  glib      
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
  };

  services = {
  	gnome-keyring = {
  	  enable = true;
  	  components = [
  	  	"secrets"
  	  	# "ssh"
  	  ];
  	};
  };
  
  systemd.user.startServices = "sd-switch";

}
