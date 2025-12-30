{ pkgs, ... }:

{

  imports = [
    ./obs.nix
    ./music.nix
    ./music-production.nix
  ];

  home = {
    packages = with pkgs; [

      ## Image and Video playback and production
      #inkscape # Vector image editing
      #shotcut # Video editing
      #blender # 3D modelling
      gimp # Image editor
      vlc # Multimedia player

      ## Miscellaneous
      themix-gui # for creating gtk themes
      orca-slicer # 3d printing slicer

    ];
  };

}
