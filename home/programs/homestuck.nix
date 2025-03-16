{ disksPath, pkgs, ... }:

{

  xdg.desktopEntries = {
    homestuck = {
      name = "The Unofficial Homestuck Collection";
      genericName = "Homestuck";
      exec =
        "appimage-run ${disksPath}/Tartarus/homosuck/Homestuck-2.5.7.AppImage";
      icon = ${pkgs.fetchurl {
        url = "https://static.wikia.nocookie.net/mspaintadventures/images/2/2d/Sburb_Logo.svg/revision/latest/scale-to-width-down/512?cb=20200130061023";
        hash = " ";
      };};
      terminal = false;
      categories = [ "Game" ];
      mimeType = [ ];
    };
  };

}
