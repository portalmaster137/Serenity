{ pkgs, inputs, osConfig, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager = {
  	userUserPackages = true;
  	userGlobalPackages = true;
  	extraSpecialArgs = { inherit inputs; };
  	users.serenity = {
  	  imports = [ (import ./../home) ];
  	  home.username = "serenity";
  	  home.homeDirectory = "/home/serenity";
  	  home.stateVersion = "23.11";
  	  programs = {
  	  	home-manager.enable = true;
  	  	direnv = {
  	  	  enable = true;
  	  	  nix-direnv.enable = true;
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
