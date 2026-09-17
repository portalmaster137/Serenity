{ self, inputs, ... }:

{

  # git module declaration
  flake.modules.nixos.git = { ... }: {

    # for home manager functionality
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    # home manager options
    home-manager.users.serenity = {

      programs = {

        git = {

          # enables git
          enable = true;

          # git settings
          settings = {

            # user details
            user = {
              name = "serenity-F";
              email = "serenity-F@noreply.codeberg.org";

              #path to signing key
              signingKey = "/home/serenity/.ssh/id_ed25519.pub";

            };

            # use ssh keys for auth
            gpg.format = "ssh";
            commit.gpgSign = true;

            # use 'main' as default branch
            init.defaultBranch = "main";

            # automatically track remote branch
            push.autoSetupRemote = true;

          };
        };

      };

    };

  };

}
