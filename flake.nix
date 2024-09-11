{
  description = "SerenityOS v0.6.0";

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

    sops-nix.url = "github:Mic92/sops-nix";
    ## optional, not necessary for the module
    #inputs.sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    ## declarative dots
    home-manager = {
  	  url = "github:nix-community/home-manager";
  	  inputs.nixpkgs.follows = "nixpkgs";
    };

    ## themeing
    nix-colors.url = "github:misterio77/nix-colors";
    
    ## ricer friendly wayland compositor
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    ## Fix broken waybar on current nixpkgs-unstable    
    waybar.url = "github:Alexays/Waybar"; 

  };

  outputs = {
    self,
    hardware,
    disko,
    nixpkgs,
    sops-nix,
    home-manager,
    nix-colors,
    hyprland,
    hyprland-plugins,
    waybar,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    ## Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {

      #iso = nixpkgs.lib.nixosSystem {
         #modules = [
           #"${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix"
           #"${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
           #disko.nixosModules.disko
           #sops-nix.nixosModules.sops
           #./hosts/iso/config.nix
         #];
         #specialArgs = {inherit inputs outputs;};
      #};
    
      persephone  = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration files <
        modules = [
          disko.nixosModules.disko
          sops-nix.nixosModules.sops
          ./hosts/persephone/config.nix
        ];
      };

      hades  = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration files <
        modules = [
          disko.nixosModules.disko
          sops-nix.nixosModules.sops
          ./hosts/hades/config.nix
        ];
      };

    };
    
  };
}

