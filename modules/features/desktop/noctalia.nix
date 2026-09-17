{ self, inputs, ... }:

{

  # noctalia shell module declaration
  flake.nixosModules.noctalia =
    { pkgs, ... }:

    {

      # for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

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

            general = { };

            # for calendar/weather
            location = { };

            # NOT YET IMPLEMENTED
            #colorSchemes.predefinedscheme = "foobar";

            # no want dock :(
            dock = {
              enabled = false;
            };

            # status bar settings
            bar = { };

          };

        };

      };

    };

}
