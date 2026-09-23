{ self, inputs, ... }:

{

  flake.nixosModules.theme1 =
    {
      config,
      lib,
      pkgs,
      ...
    }:

    let
      wallpaper = ../../assets/media/wallpapers/mimaKirigoe.jpg;
    in
    
    {

      # for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      stylix = {

        # enables automatic themeing based on wallpaper
        enable = true;
        image = ${wallpaper};

        # cursor settings
        cursor = {
          package = with pkgs; bibata-cursors;
          name = "Bibata-Modern";
          size = 25;
        };

        # font settings
        fonts = {

          # point sizes for various ui elements
          #sizes = {
          #terminal = 10;
          #desktop = 10;
          #popups = 10;
          #applications = 12;
          #};

          # emoji font to use
          emoji = {
            package = with pkgs; noto-fonts-color-emoji;
            name = "Noto Color Emoji";
          };

          # text fonts to use
          #monospace = { };
          #serif = config.stylix.fonts.sansSerif;
          #sansSerif = { };

        };
      };

      home-manager.users.serenity = {

        # copies avatar from flake into home
        home.file."avatar" = {
          source = ../../assets/media/avatar.png;
          target = "/home/serenity/Pictures/Avatars";
          recursive = true;
        };

        # copies wallpaper from flake into home
        home.file."wallpaper" = {
          source = ${wallpaper};
          target = "/home/serenity/Pictures/Wallpapers";
          recursive = true;
        };

        stylix = {

          # skews theme towards dark mode
          polarity = "dark";

          # opacity settings
          # 1.0 is opaque, 0.0 is transparent
          opacity.applications = 0.8;

          # application icons to use
          #icons = { };

        };

      };

    };
}
