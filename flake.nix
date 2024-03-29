{
  description = "Serenity's NixOS configuration";

  inputs = {
    # Nixpkgs and home mananger
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # Hardware specific configuration stuff
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # Packages
    # apoth-admin.url = "git+https://codeberg.org/Apothecary/apoth-admin.git";
    # apoth-admin.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs =
    { nixpkgs
    , nixpkgs-unstable
    , home-manager
    , nixos-hardware
    # , apoth-admin
    , ...
    }:
    let
      system = "x86_64-linux";
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
      home-manager-config = toplevel: [
        home-manager.nixosModules.home-manager # Home manager go brrrr
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          # ASK AKESI ABOUT EASIER WAY TO LOAD ALL USERS MAYBE?
          home-manager.users.serenity = toplevel;
          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
        }
      ];
      overlay-flake-pkgs = final: prev: {
      };
      common-modules = [
        ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable overlay-flake-pkgs ]; })
      ];
    in
    {
      nixosConfigurations = {
        proserpina = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/proserpina/configuration.nix # Load muir main nix config
            # nixos-hardware.nixosModules.$MODEL
          ] ++ home-manager-config (import ./hosts/proserpina/home.nix) ++ common-modules;
        };
      };
    };
}
