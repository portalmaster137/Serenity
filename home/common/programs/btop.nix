{ config, pkgs, ... }: {

  programs.btop.enable = true;
  programs.btop.settings = {
    {
      color_theme = "kyli0x";
      theme_background = false;
    }
  };

}
