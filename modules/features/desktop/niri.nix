{ self, inputs, ... }: {

  # module declaration
  flake.modules.nixos.niri = { pkgs, ... }: {

    programs.niri = {

      # enables niri
      enable = true;

    };

  };

  # defines a niri hm config
  flake.modules.homeManager.niri =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {

      imports = [
        # launcher
        self.modules.homeManager.wofi
        # desktop shell
        self.modules.homeManager.noctalia

      ];

      programs = {

        niri = {

          # enables niri
          enable = true;

          # niri settings
          settings = {

          };
        };
      };

    };

}
