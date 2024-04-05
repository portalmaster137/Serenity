{ pkgs, inputs, osConfig, ... }:

{

  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

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
  	  # programs.home-manager.enable = true;
  	};
  };

  users.users.serenity = {
  	isNormalUser = true;
  	description = "Serenity";
  	extraGroups = [
  	  "networkmanager"
  	  "wheel"
  	];
  	shell = pkgs.fish;
  };
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
  
}
