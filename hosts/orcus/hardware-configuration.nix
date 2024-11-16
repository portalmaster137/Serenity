{ lib, config, pkgs, modulesPath, ... }:

{
  imports = [ 
    ## Include results from the (non-existent) hardware scan
    ## as well as the host-specific hardware config options
    (modulesPath + "/installer/scan/not-detected.nix")

  ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/5cbed60c-33e3-4d69-a39e-c1d6d19406ea";
    fsType = "btrfs";
    options = [ "subvol=@" ];
  };

  fileSystems."/home/serenity/Disks/Tartarus" = {
    device = "/dev/disk/by-uuid/26d8d9d1-67d2-4d61-a092-10ed7368b9f6";
    fsType = "ext4";
    options = [ "users" ];
  };

   #fileSystems."/home/serenity/Disks/Orcus" = {
     #device = "/dev/disk/???";
     #fsType = "zfs";
     #options = [ ];
   #};

  swapDevices = [ ];

  ## Enable swap on luks
  boot = {
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    supportedFilesystems = [
      "btrfs"
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
        devices."luks-3de671ef-22a3-4f28-9251-a0687ab44f96" = {
          device = "/dev/disk/by-uuid/3de671ef-22a3-4f28-9251-a0687ab44f96";
           #keyFile = "/boot/crypto_keyfile.bin";
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
        device = "/dev/sda";
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
