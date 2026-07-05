{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations =
    let
      # shorten paths
      inherit (inputs.nixpkgs.lib) nixosSystem;

      homeImports = import "${self}/home/profiles";

      mod = "${self}/system";
      # get the basic config to build on top of
      inherit (import mod) base;

      # get these into the module system
      specialArgs = { inherit inputs self; };
    in
    {
      persephone = nixosSystem {
        inherit specialArgs;
        modules = base ++ [
          ./persephone
          "${mod}/core/lanzaboote.nix"

          "${mod}/programs/gamemode.nix"
          "${mod}/programs/hyprland"
          "${mod}/programs/games.nix"

          "${mod}/network/syncthing.nix"

          "${mod}/services/kanata"
          "${mod}/services/gnome-services.nix"
          "${mod}/services/location.nix"

          {
            home-manager = {
              users.mihai.imports = homeImports."mihai@io";
              extraSpecialArgs = specialArgs;
              backupFileExtension = ".hm-backup";
            };
          }

          inputs.agenix.nixosModules.default
        ];
      };

      hades = nixosSystem {
        inherit specialArgs;
        modules = base ++ [
          ./hades
          "${mod}/hardware/ddcci.nix"

          "${mod}/programs/gamemode.nix"
          "${mod}/programs/hyprland"
          "${mod}/programs/games.nix"

          "${mod}/network/syncthing.nix"

          "${mod}/services/kanata"
          "${mod}/services/gnome-services.nix"
          "${mod}/services/location.nix"

          {
            home-manager = {
              users.mihai.imports = homeImports."mihai@io";
              extraSpecialArgs = specialArgs;
              backupFileExtension = ".hm-backup";
            };
          }
        ];
      };

      nixos = nixosSystem {
        inherit specialArgs;
        modules = [
          ./wsl
          "${mod}/core/users.nix"
          "${mod}/nix"
          "${mod}/programs/zsh.nix"
          "${mod}/programs/home-manager.nix"
          {
            home-manager = {
              users.mihai.imports = homeImports.server;
              extraSpecialArgs = specialArgs;
              backupFileExtension = ".hm-backup";
            };
          }
        ];
      };
    };
}
