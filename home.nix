{ pkgs, lib, osConfig, ... }:
{

  imports = [
    # ./users.nix
    ./modules/hyprland.nix
  ];

  programs.home-manager.enable = true;

  # Copy some files to where they go
  # home.file.scripts = {
    # source = ./scripts;
    # target = ".local/bin/scripts";
  # };

 # Installing muir packages uvu
  home.packages = with pkgs; [
 # - Multimedia
    gimp
    spotify
    # jellyfin-media-player
 #  - Web & Chat
    schildichat-desktop
 #  - Coding
    # vscodium
    # gitui
  ];


  # Configure muir programs

  programs = {
  	gpg.enable = true;
  	direnv = {
  		enable = true;
  		nix-direnv.enable = true;
  		config.load_dotenv = false;
  	};
  };

  # don't uh, change this or something might break lol idk
  home.stateVersion = "23.11";
}
