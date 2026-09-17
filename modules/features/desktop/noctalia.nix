{ self, inputs, ... }:

{

  flake.nixosModules.noctalia =
    { pkgs, ... }:

    {

      # for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # home manager options
      home-manager = {

        extraSpecialArgs = {
          inherit inputs;
        };

        users.serenity = {

          # for noctalia home manager configuration
          imports = [ inputs.noctalia.homeModules.default ];
          programs.noctalia = {

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

    };

}
