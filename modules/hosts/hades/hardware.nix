{ ... }:

{

  # hardware module declaration
  flake.nixosModules.hades-hardware =

    {
      config,
      lib,
      modulesPath,
      ...
    }:

    {

      # important
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

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

      # enable amd radeon gpu drivers
      # https://nixos.wiki/wiki/AMD_GPU
      boot = {
        # exposes gpu drivers
        kernelModules = [
          "amdgpu"
          "kvm-amd"
        ];
        # gpu drivers during boot and pre boot
        initrd.kernelModules = [ "amdgpu" ];
      };
      hardware = {
        # discrete graphics support
        graphics.enable = true;
        # fixes early video issues
        amdgpu.initrd.enable = true;
      };

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
