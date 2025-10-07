{ fetchurl, pkgs, lib, }:

pkgs.stdenv.mkDerivation {
  name = "sygil-plymouth";
  version = "0.0.1";

  src = pkgs.fetchurl {
    url = "https://codeberg.org/serenity-F/sygil-plymouth/archive/0.0.1.tar.gz";
    hash = "sha256-7eqNxqkgmp3QgNmiYVBJk9hdE3gIMY+GT6PkGlCC6M0=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/plymouth/themes/sygil
    cp sygil/* $out/share/plymouth/themes/sygil
    substituteInPlace $out/share/plymouth/themes/sygil/sygil.plymouth \
      --replace-fail "/usr/" "$out/"
    runHook postInstall
  '';

  meta = {
    description = "Animated Plymouth boot theme with the Sygol sigil.";
    longDescription = ''
      Animated Plymouth theme with the Sygol sigil.
      Disk encryption password prompt is supported.
    '';
    homepage = "https://codeberg.org/serenity-F/sygil-plymouth";
    license = lib.licenses.gpl2Only;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ serenity-F ];
  };
}
