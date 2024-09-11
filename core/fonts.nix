{ inputs, outputs, lib, config, pkgs, ... }:

{

  fonts = {

    packages = with pkgs; [
      spleen
      terminus_font
      terminus_font_ttf
      (nerdfonts.override { fonts = ["NerdFontsSymbolsOnly"]; })  	  
    ];

    fontDir.enable = true;
      fontconfig = {

        defaultFonts = {
          serif = [ "spleen-32x64" ];
          sansSerif = [ "spleen-32x64" ];        
          monospace = [ "TerminusTTF" ];
        };

      };
  };

}
