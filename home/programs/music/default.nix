{ pkgs, ... }:

{

  home = {
    packages = with pkgs; [

      ## Media | Chore: Pick a music player
      strawberry # QT music player
      #lollypop # GTK music player
      spotify # Corpo music streaming
      #pragha # Music player
      #tauon # Music player
      puddletag # Music metadata editing

    ];
  };

}
