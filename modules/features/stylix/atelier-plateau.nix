{ self, inputs, ... }:

{

  # atelier-plateau theme
  flake.nixosModules.theme-atelier-plateau =
    {
      config,
      lib,
      pkgs,
      ...
    }:

    let

      # set wallpaper here
      wallpaper = ../../../assets/media/wallpapers/mimaKirigoe.jpg;

    in

    {

      imports = [

        # for home manager functionality
        inputs.home-manager.nixosModules.home-manager

        # for stylix functionality
        inputs.stylix.nixosModules.stylix

      ];

      stylix = {

        # enables automatic themeing based on wallpaper
        enable = true;
        image = "${wallpaper}";
        #polarity = "dark";
        base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-plateau.yaml";

        # cursor settings
        cursor = {
          package = with pkgs; bibata-cursors;
          name = "Bibata-Modern-Classic";
          size = 25;
        };

        # icons = {
        #   enable = true;
        #   package = with pkgs; material-icons;
        #   dark = "material-dark";
        #   light = config.stylix.icons.dark;
        # };

        # font settings
        fonts = {

          # point sizes for various ui elements
          sizes = {
            terminal = 12;
            desktop = 12;
            popups = 12;
            applications = 12;
          };

          # emoji font to use
          emoji = {
            package = with pkgs; noto-fonts-color-emoji;
            name = "Noto Color Emoji";
          };

          # text fonts to use
          monospace = {
            package = with pkgs; spleen;
            name = "Spleen 32x64";
          };
          serif = config.stylix.fonts.monospace;
          sansSerif = config.stylix.fonts.monospace;

        };
      };

      home-manager.users.serenity = {

        # copies avatar from flake into home
        home.file."Avatar" = {
          source = ../../../assets/media/avatar.png;
          target = "/home/serenity/Pictures/Avatars/";
          recursive = true;
        };

        # copies wallpaper from flake into home
        home.file."Wallpapers" = {
          source = ../../../assets/media/wallpapers;
          target = "/home/serenity/Pictures/Wallpapers";
          recursive = true;
        };

        stylix = {

          # skews theme towards dark mode
          polarity = "dark";

          # opacity settings
          # 1.0 is opaque, 0.0 is transparent
          opacity = {
            applications = 0.8;
            terminal = 0.8;
            desktop = 1.0;
            popups = 0.9;
          };

          # application icons to use
          #icons = { };

        };

      };

    };
}
