# base level inputs, should only ever be self and inputs
{ self, inputs, ... }:

# let bindings
let

  # for foo.bar
  foobar = "barbar";

in

{

  # module name declaration, as well as any required inputs
  flake.modules.nixos.kde-connect =

    { ... }:

    {

      # import system level module for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # kde connect network ports
      networking.firewall = {
        allowedUDPPortRanges = allowedTCPPortRanges;
        allowedTDPPortRanges = [
          {
            from = 1714;
            to = 65500;
          }
        ];
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
