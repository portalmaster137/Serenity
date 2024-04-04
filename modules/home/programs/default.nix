{ pkgs, ... }:

{

  imports = [
  	./git.nix
  	# ./gtk.nix
  	# ./btop.nix
  	./fish.nix
  	./kitty.nix
  	./micro.nix
  	# ./starship.nix
  	# ./vscodium.nix
  ]
	
}
