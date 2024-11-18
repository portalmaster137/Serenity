{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    ## Import necessary flake modules
     #"${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"

    ## Include results from the (non-existent) hardware scan
    ## as well as the host-specific hardware config options
    (modulesPath + "/installer/scan/not-detected.nix")

    ## Disko config, should eventually let us nuke our boot drive and reinstall
    ## with zero worries.
    #./disko.nix

    ];

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
         #"crypto_keyfile.bin" = null;
      };
       #luks = {
         #devices."luks-DISK_UUID" = {
           #device = "/dev/disk/by-uuid/DISK_UUID";
           #keyfile = "/crypto_keyfile.bin";
         #};
       #};
    };

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi = {
        canTouchEfiVariables = true;
         #efiSysMountPoint = "/boot/efi";
      };
    };

  };

  ## Hardware-related services
  services = {
    ## TRIM to keep SSDs healthy-ish
    fstrim.enable = true;

  };

  powerManagement = {
    enable = true;
    powertop.enable = true;
     #cpuFreqGovernor = Lib.mkDefault "performance";
     #cpufreq = {
       #min = 1500000;
       #max = 4400000;
     #};
  };

  hardware = {
    ## Pick either "true" OR "lib.mkDefault -"
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
     #cpu.intel.updateMicrocode = true;

    enableAllFirmware = true;
    bluetooth.enable = false;

    graphics = {
      enable = true;
      ## Packages for integrated graphics inside Persephone
      extraPackages = with pkgs; [
        intel-compute-runtime
  	intel-media-driver
  	vaapiIntel
  	vaapiVdpau
  	libvdpau-va-gl		
      ];
    };	
  };

  ## Trying out an alternate memory allocator
  environment.memoryAllocator.provider = "graphene-hardened-light";

  ## Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  ## (the default) this is the recommended approach. When using systemd-networkd it's
  ## still possible to use this option, but it's recommended to use it in conjunction
  ## with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
   #networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
   #networking.interfaces.wlp58s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
