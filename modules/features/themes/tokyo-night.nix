{ inputs, ... }:

{

  # tokyo-night-dark theme
  flake.nixosModules.theme-tokyo-night =
    {
      config,
      lib,
      pkgs,
      user-parts,
      ...
    }:

    let

      # set wallpaper here
      wallpaper = ../themes/tokyo-night.nix;

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
        polarity = "dark";
        base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-terminal-dark.yaml";

        # cursor settings
        cursor = {
          package = with pkgs; bibata-cursors;
          name = "Bibata-Modern-Classic";
          size = 25;
        };

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

      home-manager.users.${user-parts.user.username} = {

        # copies avatars from flake into home
        home.file."Avatars" = {
          source = ../../../assets/media/avatars
          target = "/home/${user-parts.user.username}/Pictures/Avatars";
          recursive = true;
        };

        # copies wallpapers from flake into home
        home.file."Wallpapers" = {
          source = ../../../assets/media/wallpapers;
          target = "/home/${user-parts.user.username}/Pictures/Wallpapers";
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
            desktop = 0.9;
            popups = 0.9;
          };

        };

      };

    };
}
