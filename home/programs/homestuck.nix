{ config, homeDir, ... }:

{

  home.file."${homeDir}/Desktop/Homestuck.desktop".text = ''
    [Desktop Entry]
    Categories=Games
    Comment=Unofficial Homestuck Collection.
    Exec=appimage-run Homestuck-2.5.7.AppImage
    GenericName=homestuck
    Icon=
    Keywords=homestuck
    MimeType=
    Name=Homestuck
    NoDisplay=false
    Path=${homeDir}/Disks/Tartarus/homosuck/Homestuck-2.5.7.AppImage
    StartupNotify=
    StartupWMClass=
    Terminal=false
    TerminalOptions=
    Type=Application
    Version=
    X-KDE-SubstituteUID=false
    X-KDE-Username=  
  '';

}
