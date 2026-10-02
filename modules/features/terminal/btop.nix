{ inputs, ... }:

{

  # defines a custom btop module
  flake.nixosModules.btop =

    { pkgs, user-parts, ... }:

    {

      # for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      environment.systemPackages = with pkgs; [ btop ];

      # home manager options
      home-manager.users.${user-parts.user.username} = {

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
