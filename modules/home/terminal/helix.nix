{ self, inputs, ... }: {

  flake.modules.homeManager.helix = {

    programs.helix = {

      enable = true; # enables helix

      settings = {

        # cursor settings
        editor.cursor-shape = {
          normal = "underline";
          insert = "bar";
          select = "block";
        };

        # declare theme to use
        theme = "onedarker_transparent";

      };

      # list of themes
      themes = {

        # modified theme
        onedarker_transparent = {
          "inherits" = "onedarker";
          "ui.background" = { };
        };

      };

      # lsp settings
      languages = {

        # nix
        language = [
          {
            name = "nix";
            auto-format = true;
            formatter.command = lib.getExe pkgs.nxfmt;
          }
        ];

      };
    };
  };
}
