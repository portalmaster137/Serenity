{ self, inputs, ... }: {

  # module declaration
  flake.nixosModules.niri = { pkgs, ... }: {

    programs.niri = {

      # enables niri
      enable = true;

    };

  };

  # defines a niri hm config
  flake.homeModules.niri =
    {
      config,
      pkgs,
      lib,
      ...
    }:

    {

      imports = with self.homeModules; [
        # launcher
        wofi
        # desktop shell
        noctalia

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
