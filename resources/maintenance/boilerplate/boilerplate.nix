{ inputs, ... }: 

let
  #foo = bar
in 

{

  flake = {

    nixosConfigurations.main = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
      ];
    };

  };
}
