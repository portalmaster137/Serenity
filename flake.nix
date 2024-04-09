{
  description = "SerenityOS v0.3.8";

  inputs = {
  
    ## Nixpkgs
    ## there was a way to have unstable as an overlay,
    ## will set it back up, lazy rn, for now pick one
    # nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";

    ## declarative disks
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## declarative dots
    home-manager = {
  	  url = "github:nix-community/home-manager";
  	  inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = {
    self,
    hardware,
    disko,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    ## Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
    
      proserpina  = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration files <
        modules = [
          disko.nixosModules.disko
          ./hosts/proserpina/configuration.nix
        ];
      };

      hades  = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration files <
        modules = [
          disko.nixosModules.disko
          ./hosts/proserpina/configuration.nix
        ];
      };

    };
    
  };
}

