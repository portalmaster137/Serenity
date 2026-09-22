{ inputs, ... }:

{

  # general music module declaration
  flake.nixosModules.music =

    { pkgs, ... }:

    {

      # for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      home-manager.users.serenity = {

        # audio effects
        services.easyeffects.enable = true;

        home.packages = with pkgs; [

          # players
          spotify # corporate garbage
          strawberry # qt music player

          # misc
          audacity # audio editing
          puddletag # file tagger

        ];

      };

    };

  # music production module declaration
  flake.nixosModules.music-production =

    { pkgs, musnix, ... }:

    {

      # for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      boot = { };

      musnix.enable = true;

      users.users.serenity.extraGroups = [ "audio" ];
      home-manager.users.serenity = {

        home.packages = with pkgs; [

          # daws
          bespokesynth

        ];

      };

    };

}
