{ pkgs, inputs, primaryUser, ... }: {
  home-manager.users.${primaryUser} = {
    # import the home manager module
    imports = [ inputs.noctalia.homeModules.default ];

    # configure options
    programs.noctalia-shell = {
      enable = true;
      settings = {
        # configure noctalia here
        bar = {
          density = "comfortable";
          position = "top";
          showCapsule = false;
          monitors = [ "DP-4" ];
          floating = true;
          marginVertical = 0.25;
          marginHorizontal = 0.5;
          widgets = {

            left = [
              {
                icon = "rocket";
                id = "CustomButton";
                leftClickExec = "qs -c noctalia ipc call launcher toggle";
              }
              { id = "ActiveWindow"; }
            ];

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
        colorSchemes.predefinedScheme = "Monochrome";
        general = {
          avatarImage = "/home/drfoobar/.face";
          radiusRatio = 0.2;
        };
        location = {
          monthBeforeDay = true;
          name = "Brisbane, Australia";
        };
      };
      # this may also be a string or a path to a JSON file,
      # but in this case must include *all* settings.
    };
  };
}
