# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, ... }:

{
  imports = [

    ./hardware-configuration.nix

    ./default.nix

  ];

  boot = {

    kernelPackages = pkgs.linuxPackages_latest;

    supportedFilesystems = [ "vfat" "ext4" ];

    loader.grub = {
      enable = true;
      device = "/dev/nvme0n1";
      enableCryptodisk = true;
    };

    initrd.luks.devices = {
      root = {
        # Use https://nixos.wiki/wiki/Full_Disk_Encryption
        device = "/dev/disk/by-uuid/5526aab7-b779-4fc8-95bd-9452bc3a9232";
        preLVM = true;
      };
    };

  };

  hardware.enableAllFirmware = true;

  nixpkgs.config.allowUnfree = true;
  
  networking = {

    hostName = "hades"; # Define your hostname.

    networkmanager = {
      enable = true;  # Easiest to use and most distros use this by default.
    };

  };

}

