{ self, inputs, ... }: {

  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = { pkgs, lib, self',... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        spawn-at-startup = [
          # Makes our custom noctalia a dependency and spawns it at startup
          (lib.getExe self'.packages.myNoctalia)
        ];

        input.keyboard.xkb.layout = "us";

        binds = {
          # Terminal bind
          "Mod+Return".spawn-sh = lib.getExe self'.packages.myKitty;
          # Launcher bind
          "Mod+Tab".spawn-sh = "${lib.getExe self.packages.myNoctalia} ipc call launcher toggle";
          # Window control binds
          "Mod+Q".close-window = null;
        };

        layout = {
          gaps = 5;
        };

      };
    };
  };

}
