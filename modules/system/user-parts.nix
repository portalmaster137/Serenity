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
        _module.args.user-parts = config.nixos.variables;
        nixos.variables = {
          home-directory = lib.mkDefault "/home/${config.nixos.user-parts.user.username}";
        };
      };
    };
}
