{ pkgs, ... }:
{
  stylix = {

    # global cursor
    cursor = {

    };

    # global fonts
    fonts = {

    };

    # global opacity
    opacity = {
      applications = 1.0;
      terminal = 0.98;
      desktop = 1.0;
      popups = 0.98;
    };


    # 'light' or 'dark' or 'either'
    polarity = "dark";

    # image to generate scheme from
    image = path/to/wallpaper.img;

    # defined colour scheme
    base16Scheme = {
      base 00 = " ";
      base 01 = " ";
      base 02 = " ";
      base 03 = " ";
      base 04 = " ";
      base 05 = " ";
      base 06 = " ";
      base 07 = " ";
      base 08 = " ";
      base 09 = " ";
      base 0A = " ";
      base 0B = " ";
      base 0C = " ";
      base 0D = " ";
      base 0E = " ";
      base 0f = " ";
    };

  };
}
