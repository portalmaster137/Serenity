{ ... }:

{

  # hardware module declaration
  flake.nixosModules.hades-hardware =

    {
      config,
      pkgs,
      lib,
      modulesPath,
      ...
    }:

    {

      # important
      imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

      # kernel modules to include
      boot.initrd.availableKernelModules = [
        "ehci_pci"
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];

      # generic kernel module options
      boot = {
        initrd.kernelModules = [ ];
        kernelModules = [ "kvm-amd" ];
        extraModulePackages = [ ];
      };

      # boot partition
      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/2C83-7F40";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      # root device configuration
      boot.initrd.luks.devices."luks-35440a88-293e-455b-a018-ee1086b07321".device =
        "/dev/disk/by-uuid/35440a88-293e-455b-a018-ee1086b07321";
      fileSystems."/" = {
        device = "/dev/mapper/luks-35440a88-293e-455b-a018-ee1086b07321";
        fsType = "ext4";
      };

      # swap device configuration
      boot.initrd.luks.devices."luks-55f7d546-fac9-4ea0-a21e-4c50ecc0d67d".device =
        "/dev/disk/by-uuid/55f7d546-fac9-4ea0-a21e-4c50ecc0d67d";
      swapDevices = [
        {
          device = "/dev/mapper/luks-55f7d546-fac9-4ea0-a21e-4c50ecc0d67d";
        }
      ];
    };

}
