{ ... }:

{

  # hardware module declaration
  flake.nixosModules.hadesHardware =

    {
      config,
      lib,
      modulesPath,
      ...
    }:

    {

      # important i think lol
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      # bootloader
      boot.loader.systemd-boot.enable = true;

      # shrug
      boot.initrd.availableKernelModules = [
        "ehci_pci"
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];

      # enable amdgpu at boot
      boot.initrd.kernelModules = [ "amdgpu" ];

      # luks device mapping
      boot.initrd.luks.devices."luks-35440a88-293e-455b-a018-ee1086b07321".device =
        "/dev/disk/by-uuid/35440a88-293e-455b-a018-ee1086b07321";
      boot.initrd.luks.devices."luks-55f7d546-fac9-4ea0-a21e-4c50ecc0d67d".device =
        "/dev/disk/by-uuid/55f7d546-fac9-4ea0-a21e-4c50ecc0d67d";

      # root partition
      fileSystems."/" = {
        device = "/dev/mapper/luks-35440a88-293e-455b-a018-ee1086b07321";
        fsType = "ext4";
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

      # swap
      swapDevices = [
        {
          device = "/dev/mapper/luks-55f7d546-fac9-4ea0-a21e-4c50ecc0d67d";
        }
      ];

      # specifies x64 uArch
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };

}
