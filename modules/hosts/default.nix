{ self, inputs, ... }: {

  flake.nixosConfigurations =
    let
      # shorten paths
      inherit (inputs.nixpkgs.lib) nixosSystem;
      homeImports = import "${self}/home/profiles";
      mod = "${self}/modules/system";
      # get the basic config to build on top of
      inherit (import mod) base;
      # get these into the module system
      specialArgs = { inherit inputs self; };
    in 

    {
      hades = nixosSystem {
        inherit specialArgs;
        modules = base ++ [
          #inputs.foo.bar
          ./hades
          "${mod}/programs/games.nix"
          "${mod}/network/syncthing.nix"
          "${mod}/services/kanata"
          {
            home-manager = {
              users.serenity.imports = homeImports."serenity";
              extraSpecialArgs = specialArgs;
              backupFileExtension = ".hm-backup";
            };
          }
        ];
      };

      nixos = nixosSystem {
        inherit specialArgs;
        modules = [
          "${mod}/users.nix"
          "${mod}/nix"
          "${mod}/programs/fish.nix"
          "${mod}/programs/home-manager.nix"
          {
            home-manager = {
              users.serenity.imports = homeImports.minimal;
              extraSpecialArgs = specialArgs;
              backupFileExtension = ".hm-backup";
            };
          }
        ];
      };

    };
}
