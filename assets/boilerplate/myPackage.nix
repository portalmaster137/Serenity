{ inputs, ... }: {

  # packages declaration
  perSystem = { pkgs, ... }: {

    #package declaration
    packages.myPackage = pkgs.stdenv.mkDerivation {

      # package options
      pname = "myPackage";
      version = "0.0.1";

    };

  };

}
