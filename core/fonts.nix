{ inputs, outputs, lib, config, pkgs, ... }:

{

  imports = [
   #./file.nix
  ];

  ## I put fonts here because i didn't know where tf else to put them lol
  ## CURRENTLY BROKEN - PLEASE FIX
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
