{ self, inputs, ... }:

{

  flake.nixosModules.noctalia =
    { pkgs, ... }:

    {

      # for home manager functionality
      imports = [
        inputs.home-manager.nixosModules.home-manager
        inputs.noctalia.homeModules.default

      ];

      # home manager options
      home-manager.users.serenity = {

        # for noctalia home manager configuration
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

            # no want dock :(
            dock = {
              enabled = false;
            };

            bar = { };

          };

        };

      };

    };

}
