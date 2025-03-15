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
      exec = "steam %U";
      terminal = false;
      categories = [ "Game" ];
      mimeType = [ ];
    };
  };

  home.file."${homeDir}/.local/share/applications/Homestuck.desktop".text = ''
    [Desktop Entry]
    Name=Homestuck
    Comment=Unofficial Homestuck Collection.
    Exec=appimage-run /home/serenity/Disks/Tartarus/homosuck/Homestuck-2.5.7.AppImage
    Icon=
    Terminal=false
    Type=Application
    Categories=Game;
  '';

}
