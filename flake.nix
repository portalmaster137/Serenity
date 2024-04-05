{
  description = "SerenityOS v0.2.5";

  inputs = {
  
    # Nixpkgs and hardware specific configs
    # there was a way to have unstable as an overlay,
    # will set it back up, lazy rn, for now pick one
    # nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # declarative disks
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # everything and anything else goes here
	# think this is a nix code formatter
	# alejandra.url = "github:kamadorueda/alejandra/3.0.0";
	
  };

  outputs = { self, nixpkgs, nixos-hardware, disko, ... }: {
    nixosConfigurations = {
      proserpina = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # nixos-hardware.nixosModules.$MODEL
          ./hosts/proserpina/configuration.nix
          disko.nixosModules.disko
        ];
      };
    };
  };

}
