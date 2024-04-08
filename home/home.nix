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
    ./theme
    ./kitty.nix
    ./git.nix
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
      # fractal
      # schildichat

      ## personal 
      obsidian
      
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
  
  programs.home-manager.enable = true;
  
  systemd.user.startServices = "sd-switch";

}
