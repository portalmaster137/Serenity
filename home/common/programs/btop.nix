{ config, pkgs, ... }: {

  programs.btop.enable = true;
  programs.btop.package = [ pkgs.btop ];
   #programs.btop.settings = {
     #color_theme = "kyli0x";
     #theme_background = false;
   #};

}
