{ self, inputs, ... }:

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

        # music daemon
        services.mpd = {
          enable = true;
          musicDirectory = /run/media/serenity/Orcus/media-share/Music;
        };

        # music player
        programs.rmpc = {
          enable = true;
        };

        home.packages = with pkgs; [

          # players
          tauon # offline usic player
          spotify # corporate garbage
          strawberry # offline music player

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

      #musnix.enable = true;

      users.users.serenity.extraGroups = [ "audio" ];
      home-manager.users.serenity = {

        home.packages = with pkgs; [

          # daws
          bespokesynth # modular synth emulator

        ];

      };

    };

}
