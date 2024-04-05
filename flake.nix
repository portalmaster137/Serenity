{
  description = "SerenityOS v0.2.5";

  inputs = {
  
    # Nixpkgs and hardware specific configs
    # nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs.url = "nixpkgs/nixos-unstable";
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
    # self,
    nixpkgs,
    nixos-hardware,
    disko,
    home-manager,
    hyprland,
    ...
  }: 

  let
    # common-modules = [
      # ({ config, pkgs, ... }:)
    # ];
    home-manager-config = toplevel: [
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.serenity = {
          	imports = [
          	  (import ./modules/core/home.nix)
          	];        	  	
          };
        };
      }
    ];
  in

  {
      nixosConfigurations = {
        proserpina = nixpkgs.lib.nixosSystem {
          system; = "x86_64-linux";
          # specialArgs = { inherit hyprland; };
          modules = [
            # nixos-hardware.nixosModules.$MODEL
            ./hosts/proserpina/configuration.nix
            disko.nixosModules.disko
          ] ++ home-manager-config;
        };
      };
  };


  system.stateVersion = "23.11";

}
