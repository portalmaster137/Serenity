{ lib, config, modulesPath, pkgs, ... }:

{
  ## Enable swap on luks
  boot = {
    initrd = {
      systemd.enable = true;
      secrets = { "/boot/crypto_keyfile.bin" = null; };
      luks = {
        devices = {
          "luks-b964f685-be70-4f87-9bd2-00cb7ba0e756" = {
            device = "/dev/disk/by-uuid/b964f685-be70-4f87-9bd2-00cb7ba0e756";
            keyFile = "/boot/crypto_keyfile.bin";
          };
          "luks-6779ede9-16e6-42f4-a13e-6da0627f8d45" = {
            device = "/dev/disk/by-uuid/6779ede9-16e6-42f4-a13e-6da0627f8d45";
            keyFile = "/boot/crypto_keyfile.bin";
          };
        };
      };
    };

    loader = {
      efi = { canTouchEfiVariables = true; };
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
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
