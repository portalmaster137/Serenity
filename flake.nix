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
#  ## Section Heading - <relevant link>
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
  description = "SerenityOS";
  ## Latest features:
  ## - Exposed large portions of `home/` import path
  ## - Abandoned multi-user support for now
  ## - Work on commenting and reformating flake is ongoing

  inputs = {

    ## Nixpkgs version - https://github.com/NixOS/nixpkgs
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };

    ## NixOS hardware - https://github.com/NixOS/nixos-hardware
    hardware = { url = "github:nixos/nixos-hardware"; };

    ## Lix language  - https://lix.systems/
    ## https://docs.lix.systems/manual/lix/stable/
    lix = {
      url = "git+https://git.lix.systems/lix-project/lix";
      flake = false;
    };

    ## Lix nixos module - https://lix.systems/add-to-config/
    lix-module = {
      url = "git+https://git.lix.systems/lix-project/nixos-module";
      inputs = {
        lix.follows = "lix";
        nixpkgs.follows = "nixpkgs";
      };
    };

    ## Flake utils - https://github.com/numtide/flake-utils
    flake-utils = { url = "github:numtide/flake-utils"; };

    ## Flake parts - https://github.com/hercules-ci/flake-parts
    flake-parts = { url = "github:hercules-ci/flake-parts"; };

    ## nixos generators
    nixos-generators = { # https://github.com/nix-community/nixos-generators
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## Declarative disks - https://github.com/nix-community/disko 
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## Secrets management - https://github.com/Mic92/sops-nix
    sops-nix = { url = "github:Mic92/sops-nix"; };

    ## Musnix - https://github.com/musnix/musnix
    musnix = { url = "github:musnix/musnix"; };

    ## Dotfiles management - https://github.com/nix-community/home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## Easy themeing - https://github.com/Misterio77/nix-colors
    nix-colors = { url = "github:misterio77/nix-colors"; };

    ## Zoomer text editor - https://github.com/nix-community/nixvim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## Nice-to-haves for gaming - https://github.com/fufexan/nix-gaming
    nix-gaming = { url = "github:fufexan/nix-gaming"; };
  };

  outputs = { self, nixpkgs, disko, sops-nix, musnix, nixos-generators,
    ## Disabled outputs - part of 'flakeification': enable and use correctly.
    #lix, lix-module, flake-utils, flake-parts, 
    #nix-colors, home-manager, nixvim,
    ... }

    @inputs:
    let

      inherit (self) outputs;

      ## Universal variable declarations
      label = "SerenityOS";
      version = "SerenityOS_0.8.9"; # proper versioning system before v1.0.0?
      primaryUser = "serenity"; # used for admin purposes
      userDesc = "Serenity Amalgam";
      homeDir = "/home/${primaryUser}"; # for easy configuration
      disksPath = "${homeDir}/Disks/"; # for easy disk navigation
      flakePath = "${homeDir}/flakes/nixdots/"; # current path to flake - unused
      #flakePath = "${homeDir}/SerenityOS/"; # for v1.0.0 release
      wallpaper =
        "${flakePath}/home/resources/wallpapers/almondBlossoms-VanGogh.jpg";

    in {

      ## Available through 'nixos-rebuild <switch> --flake /path/to/flake/directory#yourhostname'
      nixosConfigurations = {

        ## Desktop - primary config
        hades = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
            inherit label version;
            inherit flakePath disksPath;
            inherit primaryUser userDesc homeDir;
            inherit wallpaper;
          };
          modules = [
            sops-nix.nixosModules.sops
            musnix.nixosModules.musnix
            disko.nixosModules.disko
            ./core/hosts/hades
          ];
        };

        ## Home server - work in progress
        orcus = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
            inherit label version;
            inherit flakePath disksPath;
            inherit primaryUser userDesc homeDir;
            inherit wallpaper;
          };
          modules = [
            sops-nix.nixosModules.sops
            disko.nixosModules.disko
            ./hosts/orcus
          ];
        };

        ## Laptop - needs work 
        persephone = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
            inherit label version;
            inherit flakePath disksPath;
            inherit primaryUser userDesc homeDir;
            inherit wallpaper;
          };
          modules = [
            sops-nix.nixosModules.sops
            musnix.nixosModules.musnix
            disko.nixosModules.disko
            ./hosts/persephone
          ];
        };

      };

      ## Installer for easy nuke-n-paves - work in progress
      packages.x86_64-linux = {
        iso = nixos-generators.nixosGenerate {
          system = "x86_64-linux";
          format = "install-iso";
          specialArgs = {
            inherit inputs outputs;
            inherit label version;
            inherit flakePath disksPath;
            inherit primaryUser userDesc homeDir;
            inherit wallpaper;
          };
          modules = [
            sops-nix.nixosModules.sops
            musnix.nixosModules.musnix
            disko.nixosModules.disko
            ./hosts/iso
          ];
        };
      };

    };
}
