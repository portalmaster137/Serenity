{ ... }:

{

  # defines a custom fish module
  flake.nixosModules.fish =

    { pkgs, user-parts, ... }:

    {

      # Fish and Bash are installed by the system shell modules.
      environment.systemPackages = with pkgs; [
        alacritty
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
