{ pkgs, inputs, outputs, config, osConfig, ... }:

{

  imports = [
    # inputs.home-manager.nixosModules.home-manager
  ];


  users = {

    defaultUserShell = pkgs.fish;

    users.serenity = {
  	  description = "Serenity";
  	  isNormalUser = true;
  	  shell = pkgs.fish;
  	  extraGroups = [
  	    "networkmanager"
  	    "wheel"
  	  ];
    };

  };

  home-manager = {
  	useUserPackages = true;
  	useGlobalPackages = true;
  	# extraSpecialArgs = { inherit inputs; };

  	users.serenity = {
  	  imports = [ (import ./../home) ];
  	  home = {
  	  	username = "serenity";
  	  	homeDirectory = "/home/serenity/";
  	  	stateVersion = "23.11";
  	  };

  	  programs = {
  	  	home-manager.enable = true;
  	  	direnv = {
  	  	  enable = false;
  	  	  nix-direnv.enable = false;
  	  	  config.load_dotenv = false;
  	  	};
  	  };

    };

  };


  system.stateVersion = "23.11";
  
}

  # Copy some files to where they go
  # home.file.scripts = {
    # source = ./scripts;
    # target = ".local/bin/scripts";
  # };
 # Installing muir packages uvu
  # home.packages = with pkgs; [
 # - Multimedia
    # spotify
    # nicotine-plus
    # jellyfin-media-player
    # gimp
    # krita
    # inkscape
    # obs
    # ardour
    #  - Web & Chat
    # fractal
    # schildichat-desktop
    #  - Coding
    # vscodium
    # gitui
  # ];
