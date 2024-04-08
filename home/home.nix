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
    username = "serenity";
    homeDirectory = "/home/serenity";

    packages = with pkgs; [
	  vlc
      vscode     
      discord
	  firefox
      obsidian
      xfce.thunar
    ];

    stateVersion = "23.11";
  };
  
  programs.home-manager.enable = true;
  
  systemd.user.startServices = "sd-switch";

}
