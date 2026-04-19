{ user, ... }:

let

  # Name of the group needed to use VirtualBox
  vboxgroup = "vmusers";

in {

  # Permissions configuration
  users = {

    # Creates the group providing access to VirtualBox
    extraGroups."${vboxgroup}".members = [ "user-with-access-to-virtualbox" ];

    # Adds primary user to vboxusers group
    users."${user}".extraGroups = [ "vboxusers" ];

  };

  # VirtualBox configuration
  virtualisation.virtualbox = {

    # Enables VirtualBox with this machine as the host
    host.enable = true;

    # Increases security when using VirtualBox
    #host.enableHardening = true;

    # Needed for USB2 and USB3 passthrough
    host.enableExtensionPack = true;

  };

}
