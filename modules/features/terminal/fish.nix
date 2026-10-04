{ inputs, ... }:

{

  # defines a custom fish module
  flake.nixosModules.fish =

    { pkgs, user-parts, ... }:

    {

      # for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # adding shell packages to system, unsure if necessary
      environment.systemPackages = with pkgs; [
        fish # primary shell
        bash # backup shell
      ];

      # system level fish declaration
      programs.fish.enable = true;

      # home manager options
      home-manager.users.${user-parts.user.username} = {

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
              rbu = "sudo systemctl reboot --firmware-setup";
            };

            # fish functions
            functions = {

              # greeter function
              fish_greeting = ''
                echo hiya ${user-parts.user.username}, welcome to $hostname "~"

              '';

            };

          };

        };

      };

    };

}
