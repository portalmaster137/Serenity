{
  stdenvNoCC,
  fetchFromGitea,
  lib,
  unstableGitUpdater,
}:

stdenvNoCC.mkDerivation {
  name = "plymouth-sygil-theme";
  version = "0.2.0";

  src = fetchFromGitea {
    domain = "codeberg.org";
    owner = "Serenity-F";
    repo = "sygil-plymouth";
    rev = "0.2.0";
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/plymouth/themes/sygil
    cp sygil/* $out/share/plymouth/themes/sygil
    chmod +x $out/share/plymouth/themes/sygil/sygil.plymouth
    substituteInPlace $out/share/plymouth/themes/sygil/sygil.plymouth \
      --replace-fail "/usr/" "$out/"
    runHook postInstall
  '';

  passthru.updateScript = unstableGitUpdater { };

  meta = {
    description = "Animated sygil Plymouth theme.";
    homepage = "https://codeberg.org/Serenity-F/sygil-plymouth";
    license = with lib.licenses; [ gpl3Only ];
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ Serenity-F ];
  };

}
