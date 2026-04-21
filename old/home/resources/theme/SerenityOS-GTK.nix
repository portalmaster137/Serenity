{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "$name";
  src = pkgs.fetchurl {
    url = "";
    sha256 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out
    ${pkgs.unzip}/bin/unzip $src -d $out/
  '';
}
