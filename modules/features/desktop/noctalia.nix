{ inputs, ... }: {

  flake.nixosModules.noctalia =
    { config, lib, ... }:

    let
      #username = config.userOptions.username;
      #hostName = config.userOptions.hostName;
      #wallpaper = config.userOptions.wallpaper;
    in

    {

      # for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];
      home-manager.users.serenity = {
        imports = [ inputs.noctalia.homeModules.default ];

        programs.noctalia-shell = {

          # enables noctalia
          enable = true;
          systemd.enable = true;

          # noctalia settings
          settings = {

            general = { };

            location = { };

            #colorSchemes.predefinedscheme = "foobar";

            dock = {
              enabled = false;
            };

            bar = { };

          };
        };
      };
    };

}
