{ self, inputs, ... }:

{

  # defines a custom git module
  flake.nixosModules.git =

    { pkgs, user-parts, ... }:

    {

      # for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # system level git declaration
      programs.git.enable = true;

      # home manager options
      home-manager.users.${user-parts.user.username} = {

        programs = {

          # visual git
          gitui.enable = true;

          git = {

            # enables git
            enable = true;

            # git settings
            settings = {

              # user details
              user = {
                name = "${user-parts.git.username}";
                email = "${user-parts.git.email}";

                # path to signing key
                signingKey = "/home/${user-parts.user.username}/.ssh/id_ed25519.pub";

              };

              # use ssh keys for auth
              gpg.format = "ssh";
              commit.gpgSign = true;

              # use 'main' as default branch
              init.defaultBranch = "main";

              # automatically track remote branch
              push.autoSetupRemote = true;

              # use helix as editor?
              core.editor = "hx";

            };
          };

        };

      };

    };

}
