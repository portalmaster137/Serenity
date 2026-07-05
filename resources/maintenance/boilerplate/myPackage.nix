{ inputs, ... }: {

  perSystem = { pkgs, ... }: {
    packages.myPackage = pkgs.stdenv.mkDerivation {

      pname = "myPackage";
      version = "0.0.1";

    };
  };

}
