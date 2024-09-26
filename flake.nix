## SerenityOS

## - A study in linux, packaging, user experience,
##   system and desktop environments, themeing,
##   system administration, and functional programming.

## - We do not expect this to become a full-fledged linux
##   distribution. Or be adopted by anymany but ourselves,
##   but NixOS and its 'flakes' architecture allows for us
##   to experiment and learn about the required subjects
##   in a mock environment of sorts.

## - Basically, we are playing linux distro simulator. /pos


## - Oh also, code-commenting is done like this:
##   Place a hash directly before the code
##   then indent the code by 1 extra space.

## - A hash AFTER but on the same line
##   as the code lets you add any thoughts.

##  example.nix = {
##     #option1 = true;
##     #option2 = true; # disabled for x reason
##    option3 = false;
##  };

{
  description = "SerenityOS v0.6.46";
  ## Latest features:
  ## - A more defined roadmap for future flake development is now in place.
  ## - Work on ZFS support continues, expect complete functionality soon.
  ## - Work on commenting, reformating, and refactoring flake clode is progressing steadily.

  inputs = {
  
    ## Nixpkgs version
    ## there was a way to have unstable as an overlay,
    ## will set it back up, lazy rn, for now pick one
    #nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";

    ## Declarative disk management
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## Secrets management
    sops-nix = {
      url = "github:Mic92/sops-nix";
      ## optional, not necessary for the module
      #inputs.nixpkgs.follows = "nixpkgs";
    };
    
    ## Dots management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## Themeing
    nix-colors.url = "github:misterio77/nix-colors";
    
    ## Ricer friendly wayland compositor
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    ## Fix broken waybar on current nixpkgs-unstable    
    #waybar.url = "github:Alexays/Waybar"; 

    ## Graphical config editor? seeing what's up w/ it
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
        modules = [
          disko.nixosModules.disko
          sops-nix.nixosModules.sops
          ./core/hosts/persephone
        ];
      };

      hades  = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          disko.nixosModules.disko
          sops-nix.nixosModules.sops
          ./core/hosts/hades
        ];
      };

    };
    
  };
}

