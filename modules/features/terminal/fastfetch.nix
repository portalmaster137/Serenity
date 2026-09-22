{ self, inputs, ... }:

{

  # fetch module declaration
  flake.nixosModules.fetch =

    { pkgs, ... }:

    {

      # needed for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # home manager options
      home-manager.users.serenity = {

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
