{ disksPath, pkgs, ... }:

let

  homestuckPath = "${disksPath}/Tartarus/homosuck/Homestuck-2.5.7.AppImage";

  homestuckIcon = pkgs.fetchurl {
    url = ''
      https://static.wikia.nocookie.net/mspaintadventures/images/2/2d/Sburb_Logo.svg/revision/latest/scale-to-width-down/512?cb=20200130061023
    '';
    hash = "sha256-ZWPIN9CICTB+r4eJdllCm9V7em1UvVQ/SoOIxbbxIew=";
  };

in {

  xdg.desktopEntries = {
    homestuck = {
      name = "The Unofficial Homestuck Collection";
      icon = "${homestuckIcon}";
      exec = "appimage-run ${homestuckPath}";
      categories = [ "Game" ];
      genericName = "Homestuck";
      mimeType = [ ];
      terminal = false;
    };
  };

}
