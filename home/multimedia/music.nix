# # Chore: pick an offline music player already lol
## Requirements:
## - have last.fm support
## - match other UI styles
## - handle large amounts of FLAC/HiRes audio
## - optionally support metadata editing

{ pkgs, ... }:

{

  imports = [ ];

  home = {
    packages = with pkgs; [

      ## Utilities
      puddletag # Music metadata editing

      ## Music players
      spotify # corpo trash
      strawberry # QT music player
      #lollypop # GTK/Gnome native music player
      #pragha # Music player
      #tauon # Music player

    ];
  };

}
