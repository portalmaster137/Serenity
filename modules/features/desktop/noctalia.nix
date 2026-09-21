{ self, inputs, ... }:

{

  # noctalia shell module declaration
  flake.nixosModules.noctalia =
    { pkgs, ... }:

    {

      # for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # noctalia power management
      services = {
        power-profiles-daemon.enable = true;
        upower.enable = true;
      };

      # home manager options
      home-manager.users.serenity = {

        # for noctalia home manager functionality
        imports = [ inputs.noctalia.homeModules.default ];

        programs.noctalia = {

          # enables noctalia
          enable = true;
          systemd.enable = true;

          # noctalia settings
          settings = {

            general = {
              avatarImage = "../../../assets/media/avatar.png";
              radiusRatio = 0.2;
              showSessionButtonOnLockScreen = false;
              showHibernateButtonOnLockScreen = true;
            };

            # wallpaper
            wallpaper = {
              directory = "../../../assets/media/wallpapers/mimaKirigoe.jpg";
              hideWallpaperFilenames = true;
            };

            # theme
            # custom theme not yet configured
            colorSchemes.predefinedscheme = "Monochrome";

            # for calendar/weather
            location = {
              name = "Brisbane, Australia";
              monthBeforeDay = false;
            };

            # launcher - using wofi, try disable this?
            appLauncher = {
              terminalCommand = "kitty -e";
              showCategories = false;
            };

            # no want dock :(
            dock = {
              enabled = false;
            };

            # status bar settings
            bar = {
              # monitors to display on
              monitors = [ "DP-4" ];
              # position and density
              position = "top";
              floating = true;
              density = "comfortable";
              marginVertical = 0.25;
              marginHorizontal = 0.5;
              # statusbar widgets
              showCapsule = false;
              #widgets = { };
            };

            # noctalia menu settings
            #controlCenter = { };

          };

        };

      };

    };

}
