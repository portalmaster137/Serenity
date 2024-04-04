{
  description = "SerenityOS v0.2.5";

  inputs = {
  
    # Nixpkgs and hardware specific configs
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

	# nixos user repository ? :o
	# nur.url = "git:nix-community/NUR";

	# alejandra ?? think its a code formatter
	# alejandra.url = "github:kamadorueda/alejandra/3.0.0";

	# nix gaming ?
	# nix-gaming.url = "github:fufexan/nix-gaming";
	
    # declarative dots
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
	};
	
    # window manager (ricer friendly)
    hyprland = { 
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    hyprpicker.url = "github:hyprwm/hyprpicker";
    # hypr-contrib.url = "github:hyprwm/contrib";
      
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixos-hardware, home-manager, hyprland, ... }:
    let
      system = "x86_64-linux";
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
      overlay-flake-pkgs = final: prev: {
      };
      common-modules = [
        # ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable overlay-flake-pkgs ]; })
      ];
    in
    {
      nixosConfigurations = {
        proserpina = nixpkgs.lib.nixosSystem {
          inherit system;
          # specialArgs = { inherit hyprland; };
          modules = [
            ./hosts/proserpina/configuration.nix # Load muir main nix config
            # nixos-hardware.nixosModules.$MODEL
          ]; # ++ common-modules;
        };
      };
    };

}
