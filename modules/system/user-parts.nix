{ self, inputs, ... }:

{

  # user parts module declaration
  # use `${user-parts.<set>.variable};`
  # in place of regular declarations.
  # eg.
  #
  # home-manager.users.${user-parts.user.username} = {
  # OR
  # home-manager.users.${config.nixos.user-parts.user.username} = {
  #
  #   # # copies wallpapers from flake into ~/
  #   # home.file."Wallpapers" = {
  #     # source = ../../assets/media/wallpapers;
  #     # target = ${user-parts.home-directory}/Pictures/Wallpapers;
  #   # };
  #
  # };
  #
  flake.nixosModules.user-parts =

    { config, lib, ... }:

    {
      options.nixos.user-parts = {

        user = lib.mkOption {
          type = lib.types.submodule {
            options = {

              username = lib.mkOption {
                type = lib.types.str;
                default = "user";
              };

              avatar = lib.mkOption {
                type = lib.types.str;
                default = "avatar.png";
              };

              home-directory = lib.mkOption {
                type = lib.types.str;
              };

              default-locale = lib.mkOption {
                type = lib.types.str;
                default = "en_US.UTF-8";
              };

            };
          };
          default = { };
        };

        shell = lib.mkOption {
          type = lib.types.submodule {
            options = {
              user-shell = lib.mkOption {
                type = lib.types.str;
                default = "pkgs.fish";
              };
            };
          };
        };

        git = lib.mkOption {
          type = lib.types.submodule {
            options = {
              username = lib.mkOption {
                type = lib.types.str;
                default = "serenity-F";
              };
              email = lib.mkOption {
                type = lib.types.str;
                default = "serenity-F@noreply.codeberg.org";
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
        nixos.user-parts = {
          home-directory = lib.mkDefault "/home/${config.nixos.user-parts.user.username}";
        };
      };
    };
}
