{ self, inputs, ... }: {

  # module declaration
  flake.nixosModules.niri = { pkgs, lib, ... }: {

    programs.niri = {

      # enables niri
      enable = true;

      # use a custom niri package
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;

    };

  };

  # defines a custom niri package
  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {

      packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {

        # follow global packages
        inherit pkgs;

        # customised niri settings
        settings = {

          # xwayland-satellite package to use
          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

          # makes our custom noctalia a dependency and spawns it at startup
          spawn-at-startup = [
            (lib.getExe self'.packages.myNoctalia)
          ];

          # keyboard layout and binds
          input.keyboard.xkb.layout = "us";
          binds = {

            # terminal and launcher binds
            "Mod+Return".spawn-sh = lib.getExe self'.packages.myKitty;
            "Mod+Tab".spawn-sh = "${lib.getExe self.packages.myNoctalia} ipc call launcher toggle";

            # window control binds
            "Mod+Q".close-window = null;

          };

          # layout and visual settings
          layout = {

            gaps = 5;

          };

        };
      };
    };

}
