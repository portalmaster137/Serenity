{
  description = "SerenityOS v0.6.3";
  #this is a commented-out line of nix code
  ## This is a real comment

  inputs = {
  
    ## Nixpkgs
    ## there was a way to have unstable as an overlay,
    ## will set it back up, lazy rn, for now pick one
    #nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";

    ## declarative disk management
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## secrets management
    sops-nix = {
      url = "github:Mic92/sops-nix";
      ## optional, not necessary for the module
      #inputs.nixpkgs.follows = "nixpkgs";
    };
    
    ## dots management
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
    #waybar.url = "github:Alexays/Waybar"; 

    ## graphical config editor? seeing what's up w/ it
    nixos-conf-editor.url = "github:snowfallorg/nixos-conf-editor";

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
    #waybar,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    ## Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {

      #iso = nixpkgs.lib.nixosSystem {
        #specialArgs = {inherit inputs outputs;};
	 ## > Main nixos config files go here <
         #modules = [
           #"${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix"
           #"${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
           #disko.nixosModules.disko
           #sops-nix.nixosModules.sops
           #./core/hosts/iso
         #];
      #};
    
      persephone  = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        ## > Main nixos config files go here<
        modules = [
          disko.nixosModules.disko
          sops-nix.nixosModules.sops
          ./core/hosts/persephone
        ];
      };

      hades  = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Main nixos config files go here <
        modules = [
          disko.nixosModules.disko
          sops-nix.nixosModules.sops
          ./core/hosts/hades
        ];
      };

    };
    
  };
}

