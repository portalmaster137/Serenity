{ config, pkgs, ... }: {

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "kyli0x";
      theme_background = false;
    };
  };
}
