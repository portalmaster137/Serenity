{ pkgs, lib, osConfig, ... }:

{

  imports = [
    ./users
    ./desktop
    
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
    spotify
    # nicotine-plus
    # jellyfin-media-player
    # gimp
    # krita
    # inkscape
    # obs
    # ardour
    
 #  - Web & Chat
    # fractal
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
