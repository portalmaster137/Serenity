{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "serenityos-base";

  src = pkgs.fetchurl {
    url = "";
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  dontUnpack = true;
  installPhase = ''
    mkdir -p $out
    ${pkgs.unzip}/bin/unzip $src -d $out/
  '';
}
