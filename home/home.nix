{ 
  inputs,
  outputs,
  lib,
  config,
  pkgs, 
  ...
}: {

  imports = [
    ./git.nix
  ];

  home = {

    packages = with pkgs; [
  	  ## nixos
  	  appimage-run

	  ## web browsers
	  firefox
	  lagrange
	  tor-browser-bin     

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
      
    ];

    stateVersion = "23.11";
  };
  
  programs.home-manager.enable = true;
  
  systemd.user.startServices = "sd-switch";

}
