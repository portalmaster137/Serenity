{ self, inputs, ... }: {

  # niri window manager module declaration
  flake.nixosModules.niri =
    { pkgs, ... }:

    {

      # for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # packages for desktop environment
      environment.systemPackages = with pkgs; [
        #foo
        #bar
      ];

      # session management
      programs.uwsm = {
        enable = true;
        # configures uwsm to launch niri
        waylandCompositors.niri = {
          prettyName = "Niri";
          comment = "Niri scrolling WM managed by UWSM";
          # points to niri binary and declares it as a session
          binPath = "/run/current-system/sw/bin/niri";
          extraArgs = [ "--session" ];
        };
      };

      # enables niri globally
      programs.niri = {
        enable = true;
      };

      # niri settings
      home-manager.users.serenity = {

        # for niri home manager module
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
