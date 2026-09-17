{ self, inputs, ... }:

{

  # btop module declaration
  flake.modules.nixos.btop = { ... }: {

    # for home manager functionality
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    # home manager options
    home-manager.users.serenity = {

      programs = {

        btop = {

          # enables btop
          enable = true;

          # btop settings
          settings = {
            color_theme = "adapta";
            theme_background = false;
          };

        };

      };

    };

  };

}
