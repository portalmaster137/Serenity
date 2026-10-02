# base level inputs, should only ever be self and inputs
{ self, inputs, ... }:

{

  # module name declaration, as well as any required inputs
  flake.nixosModules.media-server =

    { user-parts, ... }:

    {

      # import system level module for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # system level nixflix options
      nixflix = {
        enable = true;
        mediaDir = "/run/media/serenity/Orcus/media-share";
        stateDir = "/${user-parts.user.home-directory}.config/nixflix/.state";

        # jellyfin options
        jellyfin = {
          enable = true;
          # sets main user as administrator
          users.${user-parts.user.username} = {
            policy.isAdministrator = true;
            # sets default password - change this <3
            password = "password";
          };
        };

      };

      # home manager options
      home-manager.users.${user-parts.user.username} = {

        # necessary for module name functionality
        #imports = [ ];

      };

    };

}
