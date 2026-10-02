{ ... }:

{

  # user parts module declaration

  # effectively a library of types reusable across the config
  # to save myself having to hard-code my username everywhere
  # now only needing to change it in the user.nix file

  # the hope was for this to enable multi-user, it did not
  # however i think i can use this code to do so in future

  # general usage example:
  #
  # - in your user.nix file
  # nixos.user-parts = {
  #   submodule = {
  #     variable1 = "value";
  #     variable2 = "value";
  #   };
  # };
  #
  # - in any module
  # foo.bar = "${user-parts.submodule.variable1}";
  #
  # this will let you re-use whatever values you set
  # across the entire config and saves a lot of effort

  flake.nixosModules.user-parts =

    { config, lib, ... }:

    {

      options.nixos.user-parts = {

        user = lib.mkOption {
          type = lib.types.submodule {
            options = {

              # user.username
              username = lib.mkOption {
                type = lib.types.str;
                default = "user";
              };

              # user.avatar
              avatar = lib.mkOption {
                type = lib.types.str;
                default = "avatar.png";
              };

              # user.home-directory
              home-directory = lib.mkOption {
                type = lib.types.str;
                # defalt declared below
              };

              # user.default-locale
              default-locale = lib.mkOption {
                type = lib.types.str;
                default = "en_US.UTF-8";
              };

            };
          };
          default = { };
        };

        # user shell to use
        shell = lib.mkOption {
          type = lib.types.submodule {
            options = {
              # fish, bash, zsh, etc.
              user-shell = lib.mkOption {
                type = lib.types.str;
                default = "pkgs.fish";
              };
            };
          };
        };

        # git config
        git = lib.mkOption {
          type = lib.types.submodule {
            options = {
              # git signing username
              username = lib.mkOption {
                type = lib.types.str;
                default = "user";
              };
              # git signing email
              email = lib.mkOption {
                type = lib.types.str;
                default = "user@noreply.codeberg.org";
              };
            };
          };
          default = { };
        };

      };

      config = {
        # Make `nixos-variables` available as a module argument to all NixOS
        # modules (home-manager modules already get it via extraSpecialArgs).
        _module.args.user-parts = config.nixos.user-parts;
        # sets user.home-directory's default value based on user.username's value
        nixos.user-parts.user = {
          home-directory = lib.mkDefault "/home/${config.nixos.user-parts.user.username}";
        };
      };
    };
}
