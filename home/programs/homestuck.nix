{ config, homeDir, ... }:

{

  home.file."${homeDir}/.local/share/applications/Homestuck.desktop".text = ''
    [Desktop Entry]
    Name=Homestuck
    Comment=Unofficial Homestuck Collection.
    Exec=appimage-run ~/Disks/Tartarus/homosuck/Homestuck-2.5.7.AppImage
    Icon=
    Terminal=false
    Type=Application
    Categories=Game;
  '';

  home.file."${homeDir}/.local/share/applications/Steam.desktop".text = ''
    [Desktop Entry]
    Name=Steam
    Comment=Steam !
    Exec=steam
    Icon=steam
    Terminal=false
    Type=Application
    Categories=Game;
  '';

}
