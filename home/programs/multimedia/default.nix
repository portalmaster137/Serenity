{ pkgs, ... }:

{

  home = {
    packages = with pkgs; [

      ## Image and Video playback and production
      #obs-studio # Screen sharing
      inkscape # Vector image editing
      shotcut # Video editing
      #blender # 3D modelling
      gimp # Image editor
      vlc # Multimedia player

    ];
  };

}
