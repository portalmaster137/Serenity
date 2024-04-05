{
  description = "SerenityOS v0.2.9";

  inputs = {
  
    # Nixpkgs and hardware specific configs
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    
    # declarative disks
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # declarative dots
    home-manager = {
  	  url = "github:nix-community/home-manager";
  	  inputs.nixpkgs.follows = "nixpkgs";
    };

    # ricer friendly wayland compositor
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    
  };

  outputs = { self, nixpkgs, nixos-hardware, disko, ... }@inputs: {
    nixosConfigurations = {
      proserpina = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/proserpina/configuration.nix
          # nixos-hardware.nixosModules.$MODEL
          disko.nixosModules.disko
          inputs.home-manager.nixosModules.default
        ];
      };
    };
    
  };

}
