{ disksPath, ... }:

{

  xdg.desktopEntries = {
    homestuck = {
      name = "The Unofficial Homestuck Collection";
      genericName = "Homestuck";
      exec =
        "appimage-run ${disksPath}/Tartarus/homosuck/Homestuck-2.5.7.AppImage";
      terminal = false;
      categories = [ "Game" ];
      mimeType = [ ];
    };
  };

}
