{ lib, config, pkgs, modulesPath, ... }:

{
  imports = [ 

    ## Import necessary flake modules
     #"${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"

    ## Include results from the (non-existent) hardware scan
    ## as well as the host-specific hardware config options
    (modulesPath + "/installer/scan/not-detected.nix")

    ## Disko config, should eventually let us nuke our boot drive and reinstall
    ## with zero worries.
    ## commented out for now as we have "broken" it
     #./disko.nix

    ## ZFS module, separated to help keep us sane while we set it up lol
    ./zfs.nix

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

  ## Hardware-related services
  services = {
    ## TRIM to keep SSDs healthy-ish
    fstrim.enable = true;

  };

   #powerManagement = {
     #enable = true;

     #powertop.enable = true;

     #cpuFreqGovernor = Lib.mkDefault "performance";

     #cpufreq = {
       #min = 1500000;
       #max = 4400000;
     #};
   #};

  hardware = {
    ## Pick either "true" OR "lib.mkDefault -"
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
     #cpu.intel.updateMicrocode = true;

    enableAllFirmware = true;
    bluetooth.enable = false;

    graphics = {
      enable = true;
      ## Packages for integrated graphics inside Hades
      extraPackages = with pkgs; [
        intel-compute-runtime
  	intel-media-driver
  	vaapiIntel
  	vaapiVdpau
  	libvdpau-va-gl		
      ];
    };

    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;

      amdvlk = {
        enable = true;
         #package = [ ];
        support32Bit.enable = true;
        supportExperimental.enable = true;
         #settings = {
         #};
      };

    };
  };

  programs = {
    ## For tweaking Radeon GPUs
    corectrl = {
      enable = true;
      gpuOverclock = {
        enable = true;
        ## Allows changing clocks and volts
        ppfeaturemask = "0xfffd7fff";
      };
    };

    tuxclocker = {
      enable = true;
      enableAMD = true;
      useUnfree = true;
    };

  };

  ## Some packages for managing the radeon GPU inside Hades
  environment.systemPackages = with pkgs; [
    umr
    radeontop
    nvtop-amd
    amdgpu_top
    radeontools
    radeon-profile
  ];

  ## Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  ## (the default) this is the recommended approach. When using systemd-networkd it's
  ## still possible to use this option, but it's recommended to use it in conjunction
  ## with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
   #networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
   #networking.interfaces.wlp58s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
