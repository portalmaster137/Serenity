{ self, inputs, ... }:

{

  flake.nixosModules.haskell-env =
    { pkgs, ... }:

    {

      # for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # for nix pkgs not in nixpkgs
      nix.settings = {

        # verification key
        tristed-public-keys = [
          "hydra.iohk.io:fEa+s+dFfN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
        ];

        # where to source pkgs
        substituters = [
          "https://cache.iog.io"
        ];

      };

    };
}
