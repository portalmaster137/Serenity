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
    
  };

  outputs = { nixpkgs, nixos-hardware, disko, home-manager, ... }: {
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
    homeConfigurations."serenity@proserpina" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          hyprland.homeManagerModules.default
          {wayland.windowManager.hyprland.enable = true;}
          # ...
        ];
    };

  };

}
