{ inputs, ... }:

{

  # fetch module declaration
  flake.nixosModules.fetch =

    { pkgs, user-parts, ... }:

    {

      # needed for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # home manager options
      home-manager.users.${user-parts.user.username} = {

        # stuff in those screenshots on r/unixporn
        home.packages = with pkgs; [
          peaclock # terminal clock program
          cmatrix # terminal matrix rain
        ];

        # fetch options
        programs.fastfetch = {
          enable = true;
          #settings = { };
        };

      };

    };
}
