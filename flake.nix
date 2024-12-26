# SerenityOS
#
#  A study in linux, packaging, user experience,
#  system and desktop environments, themeing,
#  system administration, and functional programming.
#
#  Basically, we are playing linux distro simulator. /pos
#
#  But seriously, we want to know things, best way to learn
#  is to jump in and experience. So that's what we shall do.
#
#  :D
#
#
#  Oh also, code-commenting is done like so:
#
#  - To mark a new SECTION of code, use two hashes (#)
#    and a space on the line BEFORE but with the same
#    indentation as the relevant code.
#
#  - A hash BEFORE the code is the standard for 
#    temporarily disabling a segment.
#
#  - A hash one space AFTER but on the same line
#    as the code lets you add any thoughts.
#
#
#  Example:
#
#  ## Section Heading
#  nixos.module = { # needed for x thing
#    option = true;
#    #otherOption = [ "$string" ]; # disabled for z reason
#    differentOption = '' # needed to make y thing work
#      text_config1 = auto
#      text_config2 = yes
#    '';
#  };
#
#  - - - - - - - - - - - - - - - - - - - - - - - -
#
#
{
  description = "SerenityOS v0.8.5";
  ## Latest features:
  ## - Big code and flake clean-up
  ## - Work on commenting and reformating flake is ongoing

  inputs = {

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

    ## Nixpkgs version
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";

    ## Declarative disk management
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## Flake parts & utils
    flake-utils = { url = "github:numtide/flake-utils"; };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      #inputs.nixpkgs.follows = "nixpkgs";
    };

    ## nixos generators
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## Secrets management
    sops-nix = {
      url = "github:Mic92/sops-nix";
      ## optional, not necessary for the module
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## Musnix - https://github.com/musnix/musnix
    musnix = { url = "github:musnix/musnix"; };

    ## Dotfiles management
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

  };

  outputs = { self, nixpkgs, disko, sops-nix, musnix, nixos-generators,
    ## Disabled outputs - part of 'flakeification': enable and use correctly.
    #lix, lix-module, flake-utils, flake-parts, 
    #nix-colors, home-manager, nixvim,
    ... }

    @inputs:
    let

      inherit (self) outputs;

      primaryUser = "serenity"; # used for admin purposes
      #flakePath = "/home/${primaryUser}/SerenityOS/"; # for v1.0.0 release
      flakePath = "/home/${primaryUser}/flakes/nixdots/"; # current path
      disksPath = "/home/${primaryUser}/Disks/";

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
            inherit primaryUser flakePath disksPath;
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
