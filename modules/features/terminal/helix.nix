{ self, inputs, ... }:

{

  # defines a custom helix module
  flake.nixosModules.helix =

    { lib, pkgs, ... }:

    {

      # needed for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # editor variables
      environment.variables = {
        EDITOR = "helix";
        VISUAL = "helix";
        SYSTEMD_EDITOR = "helix";
      };

      environment.systemPackages = with pkgs; [ helix ];

      # home manager options
      home-manager.users.serenity = {

        # primary text editor
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
            #theme = "onedarker_transparent";

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
                formatter.command = lib.getExe pkgs.nixfmt;
              }
            ];

          };
        };
      };
    };
}
