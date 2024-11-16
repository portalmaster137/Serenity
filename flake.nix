## SerenityOS
##
## - A study in linux, packaging, user experience,
##   system and desktop environments, themeing,
##   system administration, and functional programming.
##
## - We do not expect this to become a full-fledged linux
##   distribution. Or be adopted by anymany but ourselves,
##   but NixOS and its 'flakes' architecture allows for us
##   to experiment and learn about the required subjects
##   in a mock environment of sorts.
##
## - Basically, we are playing linux distro simulator. /pos
##
## - Oh also, code-commenting is done like this:
##   Place a hash directly before the code
##   then indent the code by 1 extra space.
##
## - A hash AFTER but on the same line
##   as the code lets you add any thoughts.
##
##  - - - - - - - - - - - - - - - - - - - - - - - -
##  example.nix = {
##    option1 = true;
##     #option2 = [ "$string" ];
##     #option3 = false; # disabled for x reason
##    option4 = false;
##  };
##  - - - - - - - - - - - - - - - - - - - - - - - -
##

{
  description = "SerenityOS v0.6.95"; # Nice!
  ## Latest features:
  ## - ReGreet implemented, yet to be tested
  ## - Huge progress on getting Steam working, not 100% yet
  ## - Repo makeover completed! codeberg.org/serenity-F/nixdots
  ## - Credited wallpaper artwork, and linked to code inspo
  ## - Attempting to ensure XDG was properly configured
  ## - Added Lix to flake inputs, yet to configure
  ## - Added flake parts and utils, yet to configure
  ## - Minor updates to SwayFX config
  ## - Work on commenting and reformating flake is ongoing

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

    ## Flake parts
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    ## Lix, alternative nix implementation
    lix = {
      url = "git+https://git.lix.systems/lix-project/lix";
      flake = false;
    };
    lix-module = {
      url = "git+https://git.lix.systems/lix-project/nixos-module";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.lix.follows = "lix";
    };

    ## Secrets management
    sops-nix = {
      url = "github:Mic92/sops-nix";
      ## optional, not necessary for the module
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    ## Dots management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      ## If you are not running an unstable channel of nixpkgs,
      ## select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## Graphical config editor? seeing what's up w/ it - removed ForNow:tm:
     #nixos-conf-editor.url = "github:snowfallorg/nixos-conf-editor";

    ## Easy themeing <3
    nix-colors.url = "github:misterio77/nix-colors";
    
    ## Wayland compositor with eye-candy (for edgelords)
    hyprland.url = "github:hyprwm/Hyprland";
     #hyprland.inputs.nixpkgs.follows = "nixpkgs";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    ## Fix broken waybar on current nixpkgs-unstable    
     #waybar.url = "github:Alexays/Waybar"; 

  };

  outputs = {
    self,
    nixpkgs,
    hardware,
    disko,
    sops-nix,
    home-manager,
    nixvim,
    nix-colors,
    hyprland,
    hyprland-plugins,
    #waybar,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    ## Available through 'nixos-rebuild <switch> --flake /path/to/flake/directory#yourhostname'
    nixosConfigurations = {

      ## Installer for easy nuke-n-paves
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

      ## Laptop
      persephone = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          disko.nixosModules.disko
          sops-nix.nixosModules.sops
          ./hosts/persephone
        ];
      };

      ## Desktop
      hades = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          disko.nixosModules.disko
          sops-nix.nixosModules.sops
          ./hosts/hades
        ];
      };

      ## Home server
      orcus = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          disko.nixosModules.disko
          sops-nix.nixosModules.sops
          ./hosts/orcus
        ];
      };

    };
    
  };
}

