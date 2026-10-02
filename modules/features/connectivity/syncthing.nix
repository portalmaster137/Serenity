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

        # address to serve web client on
        #guiAddress = "0.0.0.0:8384";
        #settings = {
          #options = {};
          #devices = [];
          #folders = [];
        #};
      };

      # user level configuration options
      home-manager.users.${user-parts.user.username} = {

        # import home manager modules here
        #imports = [ ];

        # syncthing packages to include
        home.packages = with pkgs; [
          syncthing
        ];

        # user level syncthing options go here
        services.syncthing = {
          enable = true;
          guiAddress = "127.0.0.1:8384"
        };

      };

    };

}
