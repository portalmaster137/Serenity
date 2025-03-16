{ disksPath, pkgs, ... }:

let

  homestuckIcon = pkgs.fetchurl {
    url = ''
      https://static.wikia.nocookie.net/mspaintadventures/images/2/2d/Sburb_Logo.svg
    '';
    hash = "sha256-ZWPIN9CICTB+r4eJdllCm9V7em1UvVQ/SoOIxbbxIew=";
  };

  ## ${homestuckPath} requires you to complete the regular setup requirements
  ## detailed at https://homestuck.giovanh.com/unofficial-homestuck-collection
  homestuckPath = "${disksPath}/Tartarus/homosuck/Homestuck-2.5.7.AppImage";

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
