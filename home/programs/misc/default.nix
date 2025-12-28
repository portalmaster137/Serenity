{ pkgs, ... }:

{

  imports = [
    ./homestuck.nix # small module to add a .desktop entry for The Unofficial Homestuck Collection
  ];

  home = {
    packages = with pkgs; [
      cmatrix # funky terminal matrix rain
      peaclock # neat terminal clock applet
      themix-gui # for creating themes
      nexusmods-app-unfree # skyrim mods lol
      orca-slicer # 3d printing slicer
    ];
  };
}
