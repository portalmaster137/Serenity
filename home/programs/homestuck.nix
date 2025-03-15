{ homeDir, disksPath, ... }:

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

    steam = {
      name = "Steam";
      genericName = "Steam";
      exec = "DRI_PRIME=0 steam %U";
      terminal = false;
      categories = [ "Game" ];
      mimeType = [ ];
    };
  };

}
