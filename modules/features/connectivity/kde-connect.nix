# base level inputs, should only ever be self and/or inputs
{ ... }:

{

  # kde connect module
  flake.nixosModules.kde-connect =

    { user-parts, ... }:

    {

      # kde connect network ports
      networking.firewall = rec {
        allowedTCPPortRanges = [
          {
            from = 1714;
            to = 1716;
          }
        ];
        allowedUDPPortRanges = [
          {
            from = 1714;
            to = 1716;
          }
        ];

      };

      # system level options
      programs.kdeconnect = {
        enable = true;
      };

      # environment.systemPackages = [
      #   kdeconnect-send.yazi
      # ];

      # home manager options
      home-manager.users.${user-parts.user.username} = {

        # kde connect user level options
        services.kdeconnect = {
          enable = true;
          indicator = true;
        };

      };

    };

}
