{ inputs, ... }:

# let bindings
let

  #foo = bar
  #

in

{

  # try `$ nix run .#boilerplate`
  flake = {

    # modules declaration
    nixosConfigurations.main = inputs.nixpkgs.lib.nixosSystem {

      # list of modules to import
      modules = [
        ./configuration.nix
      ];

    };

  };

}
