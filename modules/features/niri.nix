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

        spawn-at-startup = [
          # Makes our custom noctalia a dependency and spawns it at startup
          (lib.getExe self'.packages.myNoctalia)
        ];

        binds = {
          "Mod+Tab".spawn-sh = "${lib.getExe self.packages.myNoctalia} ipc call launcher toggle";
        };

        layout = {
          gaps = 5;
          foo = 20;
        };

      };
    };
  };

}
