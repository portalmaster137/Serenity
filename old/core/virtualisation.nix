{ user, pkgs, ... }:

let
  
  #sharePublicSourceDirectory = "/home/${user}/Public/"; # it's named public right
  #sharePublicTargetDirectory = "F:"; # for windows

in {

  # Security
  #users.groups = { # creates grouped virtualisation permissions
    #kvm.members = [ "${user}" "${anotherUser}" ];
    #libvirtd.members = [ "${user}" "${anotherUser}" ];
  #};
  users.users."${user}" = { # Gives primary user virtualisation permissions
    extraGroups = [ "libvirtd" "kvm" ];
  };
  networking.firewall.trustedInterfaces = [ "virbr0" ]; # network bridge to VM
  # https://wiki.nixos.org/wiki/Virt-manager#Networking
  # Inactive by default, enable in host by running:
  # `sudo virsh net-start default`
  # Enable it automatically it at boot by running:
  # `sudo virsh net-autostart default`

  # virtualisation
  programs.virt-manager.enable = true; # simple vm frontend
  environment.systemPackages = with pkgs; [
    dnsmasq # for vm networking
    #phodav # for vm fileshare
  ];
  virtualisation = {
    spiceUSBRedirection.enable = true; # for USB passthrough
    libvirtd = {
      enable = true;
      qemu = {
        vhostUserPackages = with pkgs; [ virtiofsd ]; # host fileshare
        swtpm.enable = true; # tpm emulation for windows 11
        runAsRoot = true; # for `passthrough` security on fileshare
      };
    };
  };

}
