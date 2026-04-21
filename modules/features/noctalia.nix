{ self, inputs, ... }: {

  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.noctalia-shell = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia;
    };
  };

  perSystem = { pkgs, ... }: {

    packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;
      settings = {
        foo = bar;
        foorbar = {
          bar = true;
          foo = "always";
          barbar = 5;
        };
      };
    };

  };

}
