{ ... }:

{

  # fetch module declaration
  flake.nixosModules.fetch =

    { pkgs, user-parts, ... }:

    {

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
