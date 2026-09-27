{ self, inputs, ... }:

{

  # defines a custom git module
  flake.nixosModules.git =

    { pkgs, ... }:

    {

      # for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # system level git declaration
      programs.git.enable = true;

      # home manager options
      home-manager.users.serenity = {

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

              # use helix as editor?
              core.editor = "hx";

            };
          };

        };

      };

    };

}
