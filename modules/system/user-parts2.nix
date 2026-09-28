{ self, inputs, ... }:

{

  flake.nixosModules.variables =

    {
      config,
      lib,
      pkgs,
      ...
    }:

    {
      options.nixos.variables = {
        user = lib.mkOption {
          type = lib.types.submodule {
            options = {
              username = lib.mkOption {
                type = lib.types.str;
                default = "user";
              };
              default-shell = lib.mkOption {
                type = lib.types.package;
                default = pkgs.nushell;
                defaultText = lib.literalExpression "pkgs.nushell";
              };
            };
          };
          default = { };
        };

        git = lib.mkOption {
          type = lib.types.submodule {
            options = {
              username = lib.mkOption {
                type = lib.types.str;
                default = "DontBlameMe";
              };
              email = lib.mkOption {
                type = lib.types.str;
                default = "dontblameme@noreply.codeberg.org";
              };
            };
          };
          default = { };
        };

        home-directory = lib.mkOption {
          type = lib.types.str;
        };

        default-locale = lib.mkOption {
          type = lib.types.str;
          default = "en_US.UTF-8";
        };

      };

      config = {
        # Make `nixos-variables` available as a module argument to all NixOS
        # modules (home-manager modules already get it via extraSpecialArgs).
        _module.args.nixos-variables = config.nixos.variables;
        nixos.variables = {
          home-directory = lib.mkDefault "/home/${config.nixos.variables.user.username}";
        };
      };
    };
}
