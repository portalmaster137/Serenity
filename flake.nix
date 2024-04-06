{
  description = "SerenityOS v0.3.2-1";

  inputs = {
  
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";

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
    # hyprland-plugins = {
      # url = "github:hyprwm/hyprland-plugins";
      # inputs.hyprland.follows = "hyprland";
    # };

  };

  outputs = {
    self,
    hardware,
    disko,
    nixpkgs,
    home-manager,
    hyprland,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # Available through 'nixos-rebuild --flake .#your-hostname'
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
