{ self, inputs, ... }:

{

  # noctalia shell module declaration
  flake.nixosModules.noctalia =

    { pkgs, ... }:

    {

      # for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # binary cache to reduce rebuild time
      nix.settings = {
        extra-substituters = [
          "https://noctalia.cachix.org"
        ];
        extra-trusted-public-keys = [
          "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        ];
      };

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
            colorSchemes = {
              darkMode = true;
              pureBlack = true;
              useWallpaperColors = true;
              generationMethod = "fruit-salad";
            };

            # for calendar/weather
            location = {
              name = "Brisbane, Australia";
              monthBeforeDay = false;
            };

            # launcher
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
              widgets = {

                left = [ ];

                center = [
                  {
                    hideUnoccupied = false;
                    id = "Workspace";
                    labelMode = "none";
                  }
                ];

                right = [
                  {
                    # system tray/overflow
                    id = "tray";
                  }
                  {
                    # wifi/networking widget
                    id = "WiFi";
                  }
                  {
                    # bluetooth devices/pairing
                    id = "Bluetooth";
                  }
                  {
                    # battery for laptop
                    alwaysShowPercentage = false;
                    id = "Battery";
                    warningThreshold = 30;
                  }
                  {
                    # statusbar clock
                    formatHorizontal = "HH:mm";
                    formatVertical = "HH mm";
                    id = "Clock";
                    useMonospacedFont = true;
                    usePrimaryColor = true;
                  }
                  {
                    # quick settings
                    id = "ControlCenter";
                    #useDistroLogo = true;
                  }
                ];

              };
            };

          };

        };

      };

    };

}
