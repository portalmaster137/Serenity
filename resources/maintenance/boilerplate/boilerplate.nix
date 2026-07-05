{ inputs, ... }: 

let
  #foo = bar
in 

{

  # Try `$ nix run .#boilerplate`
  flake = {

    nixosConfigurations.main = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
      ];
    };

  };
}
