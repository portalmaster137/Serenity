# base level inputs and arguments, should only ever be self and inputs
{ self, inputs, ... }:

{

  # module name declaration
  flake.nixosModules.syncthing =

    # function inputs and arguments
    { pkgs, user-parts, ... }:

    # system level configuration options
    {

      # import system level module for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # opens network ports for syncthing
      networking.firewall = {
        allowedTCPPorts = [ 8384 ];
        allowedUDPPorts = [ 8384 ];
      };

      # system level syncthing options go here
      services.syncthing = {
        enable = true;
        openDefaultPorts = true;
      };

      # user level configuration options
      home-manager.users.${user-parts.user.username} = {

        # import home manager modules here
        #imports = [ ];

        # syncthing packages to include
        home.packages = with pkgs; [
          syncthing # syncthing package
          git-sync # for sync version control
        ];

        # user level syncthing options go here
        services.syncthing = {
          enable = true;
          guiAddress = "127.0.0.1:8384";
        };

        # sync version control
        services.git-sync = {
          enable = true;

          # obsidian notes vault lives here
          repositories.notes = {
            path = "${user-parts.user.home-directory}/Sync/Notes/";
            uri = "git@codeberg.org:${user-parts.git.username}/Notes.git";
            interval = 1000;
          };

          # password kbdx file lives here
          repositories.keyring = {
            path = "${user-parts.user.home-directory}/Sync/Keyring";
            uri = "git@codeberg.org:${user-parts.git.username}/Keyring";
            interval = 1000;
          };

        };

      };

    };

}
