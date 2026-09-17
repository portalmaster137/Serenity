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

        # for noctalia shell atop niri
        self.nixosModules.noctalia

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
        programs.niri = {

          settings = {

          };

        };

      };

    };

}
