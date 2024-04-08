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
  ];

  home = {
    username = "serenity";
    homeDirectory = "/home/serenity";

    packages = with pkgs; [
	  firefox
	  lagrange
	  tor-browser-bin     
      discord
      obsidian
      vscode
	  kitty
	  micro
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
