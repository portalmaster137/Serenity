# # SerenityOS
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
  description = "SerenityOS v0.8.5";
  ## Latest features:
  ## - Big code and flake clean-up
  ## - Switched to SwayFX full-time
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
    flake-utils = { url = "github:numtide/flake-utils"; };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      #inputs.nixpkgs.follows = "nixpkgs";
    };

    ## Lix, alternative nix implementation
    lix = { # lix language
      url = "git+https://git.lix.systems/lix-project/lix";
      flake = false;
    };
    lix-module = { # lix nixos module
      url = "git+https://git.lix.systems/lix-project/nixos-module";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.lix.follows = "lix";
    };

    ## Musnix - https://github.com/musnix/musnix
    musnix = { url = "github:musnix/musnix"; };

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

    ## Zoomer text editor
    nixvim = {
      url = "github:nix-community/nixvim";
      ## If you are not running an unstable channel of nixpkgs,
      ## select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## Easy themeing <3
    nix-colors.url = "github:misterio77/nix-colors";

    ## nixos generators
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, disko, sops-nix, musnix, nixos-generators, ... }

    @inputs:
    let

      inherit (self) outputs;

      username = "serenity";

    in {

      ## Installer for easy nuke-n-paves
      packages.x86_64-linux = {
        install-iso = nixos-generators.nixosGenerate {
          system = "x86_64-linux";
          modules = [ ./hosts/iso ];
          format = "install-iso";
          specialArgs = { inherit inputs outputs; };
        };
      };

      ## Available through 'nixos-rebuild <switch> --flake /path/to/flake/directory#yourhostname'
      nixosConfigurations = {

        ## Desktop
        hades = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
            inherit username;
          };
          modules = [
            musnix.nixosModules.musnix
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            ./hosts/hades
          ];
        };

        ## Home server
        orcus = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            ./hosts/orcus
          ];
        };

        ## Laptop
        persephone = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            ./hosts/persephone
          ];
        };

      };

    };
}
