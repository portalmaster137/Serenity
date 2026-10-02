# base level inputs and arguments, should only ever be self and/or inputs
{ inputs, ... }:

{

  # virtualisation module declaration
  flake.nixosModules.virtualisation =

    { pkgs, user-parts, ... }:

    {

      # for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # adding user to required groups
      users.users.${user-parts.user.username} = {
        extraGroups = [
          "libvirtd"
          "kvm"
        ];
      };

      # network bridge to vm
      networking.firewall.trustedInterfaces = [ "virbr0" ];

      #virtualisation program
      programs.virt-manager = {
        enable = true;
      };

      # for vm networking
      environment.systemPackages = with pkgs; [ dnsmasq ];

      # virtualisation settings
      virtualisation = {
        # usb passthrough
        spiceUSBRedirection.enable = true;
        libvirtd = {
          enable = true;
          qemu = {
            # host fileshare with vm
            vhostUserPackages = with pkgs; [ virtiofsd ];
            # tpm emulation for win11
            swtpm.enable = true;
            # passthrough security on fileshare
            runAsRoot = true;
          };
        };
      };
    };
}
