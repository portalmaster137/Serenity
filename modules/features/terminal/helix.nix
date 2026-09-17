{
  self,
  inputs,
  pkgs,
  lib,
  ...
}:
{

  # defines a custom helix module
  flake.nixosModules.helix = {

    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager.users.serenity = {

      home.packages = with pkgs; [
        helix
      ];

      programs.helix = {

        # enables helix
        enable = true;

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
  };
}
