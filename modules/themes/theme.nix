{ self, inputs, ... }:

{

  flake.nixosModules.theme1 =
    {
      config,
      lib,
      pkgs,
      ...
    }:

    {

      # for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      home-manager.users.serenity = {

        home = {

          # copies avatar from flake into home
          file."avatar" = {
            source = ./assets/media/avatar.png;
            target = "/home/serenity/Pictures/Avatars";
            recursive = true;
          };

          # copies wallpapers from flake into home
          file."wallpapers" = {
            source = ./assets/media/wallpapers;
            target = "/home/serenity/Pictures/Wallpapers";
            recursive = true;
          };

        };

      };

    };
}
