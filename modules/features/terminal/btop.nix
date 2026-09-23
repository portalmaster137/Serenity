{ self, inputs, ... }:

{

  # defines a custom btop module
  flake.nixosModules.btop =

    { pkgs, ... }:

    {

      # for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      environment.systemPackages = with pkgs; [ btop ];

      # home manager options
      home-manager.users.serenity = {

        programs = {

          btop = {

            # enables btop
            enable = true;

            # btop settings
            settings = {
              #color_theme = "adapta";
              theme_background = false;
            };

          };

        };

      };

    };

}
