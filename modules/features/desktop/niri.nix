{ self, inputs, ... }: {

  # module declaration
  flake.nixosModules.niri =
    {
      lib,
      pkgs,
      ...
    }:

    let

      #username = config.userOptions.username;

    in

    {

      imports = [

        # for home manager functionality
        inputs.home-manager.nixosModules.home-manager
        inputs.niri.homeModules.niri

        # for noctalia shell atop niri
        #self.nixosModules.noctalia

      ];

      environment = {

        # packages for desktop environment
        systemPackages = with pkgs; [
          foo
          bar
        ];

      };

      # session management
      programs.uwsm = {
        enable = true;
      };

      # enables niri globally
      programs.niri = {
        enable = true;
      };

      # niri settings
      home-manager.users.serenity = {

        imports = [ inputs.niri.homeModules.niri ];

        programs.niri = {

          # enables niri within home manager
          enable = true;

          # niri configuration
          #settings = { };

        };

      };

    };

}
