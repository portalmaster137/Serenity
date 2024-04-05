{
  description = "SerenityOS v0.2.5";

  inputs = {
  
    # Nixpkgs and hardware specific configs
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    
	# alejandra ?? think its a nix code formatter
	# alejandra.url = "github:kamadorueda/alejandra/3.0.0";

    # declaratice disks
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	
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
      
  };

  outputs = { 
    self,
    nixpkgs,
    nixpkgs-unstable,
    nixos-hardware,
    disko,
    home-manager,
    hyprland,
    ...
  }:
  
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
        ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable overlay-flake-pkgs ]; })
      ];
    in
    {
      nixosConfigurations = {
        proserpina = nixpkgs.lib.nixosSystem {
          inherit system;
          # specialArgs = { inherit hyprland; };
          modules = [
            disko.nixosModules.disko
            ./hosts/proserpina/configuration.nix # Load muir main nix config
            # nixos-hardware.nixosModules.$MODEL
          ] ++ common-modules;
        };
      };
    };

}
