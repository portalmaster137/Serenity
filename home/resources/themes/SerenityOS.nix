{
  imports = [
    #./template.nix
  ];

  theme = {
    wallpaper = "../wallpapers/almondBlossoms-VanGogh.jpg";
    lockscreenWallpaper = "../wallpapers/attunement-HelveticaBlanc.png";
    waybar-transparent = true;
    font-mono = "spleen 32x64";
    font = "spleen 32x64";
    rounding = 18;
    gaps-in = 4;
    gaps-out = 8;
    border-size = 1;

    colors = {
      bg = "000000";
      fg = "FCFCFC";
      alt-bg = "101012";
      alt-fg = "ECECEC";
      primary-ansi-16 = "cyan";
      primary-bg = "00cdff";
      primary-fg = "000000";
      secondary-bg = "11222e";
      secondary-fg = "000000";
      color0 = "000000";
      color1 = "f7768e";
      color2 = "73daca";
      color3 = "cfb264";
      color4 = "7a82f7";
      color5 = "a778F8";
      color6 = "7dd8ff";
      color7 = "E4E5E7";
      color8 = "515878";
      color9 = "f7869e";
      color10 = "83eada";
      color11 = "f0bf78";
      color12 = "8ab2f7";
      color13 = "A988F8";
      color14 = "8ddfff";
      color15 = "f4f5f7";
    };
  };

}
