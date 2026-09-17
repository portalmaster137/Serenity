{ self, inputs, ... }:

{

  # defines a custom fish module
  flake.modules.nixos.fish = { pkgs, ... }: {

    # for home manager functionality
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    # home manager options
    home-manager.users.serenity = {

      # program settings
      programs = {

        # starship prompt
        starship = {
          enable = true;
        };

        # fish shell
        fish = {

          # enables fish
          enable = true;

          # shell initialisation
          loginShellInit = "";
          interactiveShellInit = "";

          # fish plugins
          plugins = [

            {
              name = "done";
              src = pkgs.fishPlugins.done.src;
            }

            {
              name = "puffer";
              src = pkgs.fishPlugins.puffer.src;
            }
            
            {
              name = "autopair";
              src = pkgs.fishPlugins.autopair.src;
            }
          ];

          # command aliases & abbreviations
          shellAbbrs = {
            nv = "hx";
            nvim = "hx";
            trc = "tree -C";
          };
          shellAliases = {
            rbu "sudo systemctl reboot --firmware-setup";
          };

          # fish functions
          functions = {

            # foo
            foo = ''
                if bar
                  printf 'foo'
                else
                  echo loser
                end
              '';
          };

        };

      };

    };

  };

}
