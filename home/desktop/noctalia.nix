{
  inputs, outputs, config, pkgs,
  user, userDescription, 
  homeDirectory, 
  wallpapersPath, wallpaper, 
  avatarsPath, avatar,  
  ... 
}:

{
  #home-manager.users.${user} = {
    # import the home manager module
    imports = [ inputs.noctalia.homeModules.default ];

    # configure options
    programs.noctalia-shell = {
      enable = true;
      settings = {
        # configure noctalia here

        general = {
          avatarImage = "${avatar}";
          radiusRatio = 0.2;
          showSessionButtonOnLockScreen = false;
          showHibernateOnLockScreen = true;
        };

        location = {
          monthBeforeDay = true;
          name = "Brisbane, Australia";
        };

        colorSchemes = { predefinedScheme = "Monochrome"; };

        wallpaper = {
          directory = "${wallpapersPath}";
          hideWallpaperFilenames = true;

        };

        appLauncher = {
          terminalCommand = "kitty -e";
          showCategories = false;
        };

        bar = {
          density = "comfortable";
          position = "top";
          showCapsule = false;
          monitors = [ "DP-4" ];
          floating = true;
          marginVertical = 0.25;
          marginHorizontal = 0.5;
          widgets = {

            left = [{
              icon = "rocket";
              id = "CustomButton";
              leftClickExec = "wofi";
            }];

            center = [{
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "none";
            }];

            right = [
              { id = "Tray"; }
              { id = "WiFi"; }
              { id = "Bluetooth"; }
              {
                alwaysShowPercentage = false;
                id = "Battery";
                warningThreshold = 30;
              }
              {
                formatHorizontal = "HH:mm";
                formatVertical = "HH mm";
                id = "Clock";
                useMonospacedFont = true;
                usePrimaryColor = true;
              }
              {
                id = "ControlCenter";
                useDistroLogo = true;
              }
            ];

          };
        };
        #ControlCenter = { };
      };
      # this may also be a string or a path to a JSON file,
      # but in this case must include *all* settings.
    };
  #};
}
