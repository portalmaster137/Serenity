{ user, pkgs, ... }:

let

  # Name of the group needed to use VirtualBox
  vmgroup = "vmusers";

in {

  # Permissions configuration
  users = {
    # Gives users virtualisation permissions
    groups.kvm.members = [ "${user}" ];
    groups.libvirtd.members = [ "${user}" ];
    extraGroups."${vmgroup}".members = [ "${user}" ];
    users."${user}".extraGroups = [ "${vmgroup}" ];
  };

  # Virtualisation packages
  environment.systemPackages = with pkgs; [
    gnome-boxes # VM frontend
    dnsmasq # Vm networking
    phodav # Fileshare with guest VMs
  ];

  # Virtualisation configuration
  virtualisation = {
    # Base virtualisation set up
    libvirtd.enable = true;
    # TPM emulation for Win11
    libvirtd.qemu = {
      swtpm.enable = true;
    };
    # Enables USB passthrough
    spiceUSBRedirection.enable = true;
    # VirtualBox configuration
    virtualbox = {
      # Enables VirtualBox with this machine as the host
      #host.enable = false;
      # Increases security when using VirtualBox
      #host.enableHardening = true;
      # Needed for USB2 and USB3 passthrough
      #host.enableExtensionPack = true;
    };
  };
}
