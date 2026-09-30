# base level inputs, should only ever be self and inputs
{ self, inputs, ... }:

{

  # module name declaration, as well as any required inputs
  flake.modules.nixos.kde-connect =

    { ... }:

    {

      # import system level module for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # kde connect network ports
      networking.firewall = rec {
        allowedTCPPortRanges = [
          {
            from = 1714;
            to = 65500;
          }
        ];
        allowedUDPPortRanges = allowedTCPPortRanges;
      };

      # system level options
      programs.kdeconnect = {
        enable = true;
      };

      # home manager options
      home-manager.users.serenity = {

        # kde connect user level options
        services.kdeconnect = {
          enable = true;
          indicator = true;
        };

      };

    };

}
