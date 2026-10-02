# base level inputs and arguments, should only ever be self and inputs
{ self, inputs, ... }:

{

  # module name declaration
  flake.modules.nixos.syncthing =

    # function inputs and arguments
    { pkgs, user-parts, ... }:

    # system level configuration options
    {

      # import system level module for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # opens network ports for syncthing
      networking.firewall = {
        allowedTCPPorts = [ 8384 ];
        allowedUDPPorts = [ 8834 ];
      };

      # system level syncthing options go here
      services.syncthing = {
        #enable = true;
      };

      # user level configuration options
      home-manager.users.${user-parts.user.username} = {

        # import home manager modules here
        #imports = [ ];

        # user level syncthing options go here
        services.syncthing = {
          #enable = true;
        };

      };

    };

}
