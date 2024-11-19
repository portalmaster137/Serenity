{ lib, config, modulesPath, ... }:

{
  imports = [ 
    ## Include results from the (non-existent) hardware scan
    ## as well as the host-specific hardware config options
    (modulesPath + "/installer/scan/not-detected.nix")

  ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/11de1abe-9a4b-47be-8d1f-034ea9c357df";
    fsType = "ext4";
  };

  fileSystems."/home/serenity/Disks/Tartarus" = {
    device = "/dev/disk/by-uuid/26d8d9d1-67d2-4d61-a092-10ed7368b9f6";
    fsType = "ext4";
    options = [ "users" ];
  };


  swapDevices = [ {
    device = "/dev/disk/by-uuid/2321fc38-ebae-464e-b19b-f929bf18f0f1";
  } ];

  ## Enable swap on luks
  boot = {
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    supportedFilesystems = [
      "xfs"
      "ntfs"
    ];

    initrd = {
      systemd.enable = true;
      kernelModules = [ ];
      availableKernelModules = [
        "xhci_pci"
        "ehci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];

      secrets = {
        "/boot/crypto_keyfile.bin" = null;
      };

      luks = {
        devices."luks-b964f685-be70-4f87-9bd2-00cb7ba0e756" = {
          device = "/dev/disk/by-uuid/b964f685-be70-4f87-9bd2-00cb7ba0e756";
          keyFile = "/boot/crypto_keyfile.bin";
        };
      };

      luks = {
        devices."luks-6779ede9-16e6-42f4-a13e-6da0627f8d45" = {
          device = "/dev/disk/by-uuid/6779ede9-16e6-42f4-a13e-6da0627f8d45";
          keyFile = "/boot/crypto_keyfile.bin";
        };
      };

    };

    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      ## For some reason GPT/UEFI didn't work, so neither does systemd-boot
      ## stuck using MBR/DOS and GRUB instead
      grub = {
        enable = true;
        device = "/dev/nvme0n1";
        useOSProber = true;
        enableCryptodisk = true;
      };
    };

  };
  ## Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  ## (the default) this is the recommended approach. When using systemd-networkd it's
  ## still possible to use this option, but it's recommended to use it in conjunction
  ## with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
   #networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
   #networking.interfaces.wlp58s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
