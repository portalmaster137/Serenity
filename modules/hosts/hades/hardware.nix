{ ... }:

{
  # defines a module
  flake.nixosModules.hadesHardware =
    {
      config,
      lib,
      modulesPath,
      ...
    }:

    {

      # important i think lol
      imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

      boot.loader.systemd-boot.enable = true;

      # shrug
      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];

      # enable amdgpu at boot
      boot.initrd.kernelModules = [ "amdgpu" ];

      # root partition
      fileSystems."/" = {
        device = "/dev/disk/by-uuid/2f4a231c-04a1-4bb9-9370-c207573be881";
        fsType = "ext4";
      };

      # boot partition
      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/7D2E-5F33";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      # swap
      swapDevices = [ ];

      # specifies x64 uArch
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
