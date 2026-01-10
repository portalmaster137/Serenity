{ pkgs, ... }:

{

  imports = [
    ./web.nix
    ./obs.nix
    ./music.nix
    ./music-production.nix
  ];

  ## Easy effects daemon
  services.easyeffects.enable = true;

  home.packages = with pkgs; [
    ## Audio
    helvum # Patchbay
    pavucontrol # Volume control
    easyeffects # Effects and routing
    ## Image
    gimp # General image editing
    #inkscape # Vector image editing
    ## Video
    vlc # Video playback
    #shotcut # Video editing
    ## 3D Creative
    blender # 3D modelling software
    orca-slicer # 3D print slicing
    ## Miscellaneous
    themix-gui # for creating gtk themes
  ];
}
