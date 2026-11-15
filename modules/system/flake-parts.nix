{ ... }:

{

  # misc flake-parts configuration
  config = {

    # uarchs to build for
    systems = [ "x86_64-linux" ];

    perSystem = { pkgs, ... }: {
      formatter = pkgs.nixfmt-tree;
    };

  };

}
