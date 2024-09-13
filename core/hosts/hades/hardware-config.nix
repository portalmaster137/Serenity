{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ 
    (modulesPath + "/installer/scan/not-detected.nix")
    ## commented out disko for now as I have broken it :D
    #./disko.nix
  ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/5cbed60c-33e3-4d69-a39e-c1d6d19406ea";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  swapDevices = [ ];

  ## Enable swap on luks
  boot = {
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    initrd = {
	  availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
	  kernelModules = [ ];
      systemd.enable = true;
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
      ## for some reason GPT/UEFI didn't work, so neither does systemd-boot
      ## stuck using MBR/DOS and GRUB instead
      grub = {
        enable = true;
        device = "/dev/sda";
        enableCryptodisk = true;
      };  
    };

  };

  ## trim to keep SSDs healthy-ish
  services.fstrim.enable = true;

  hardware = {
    ## Pick either "true" OR "lib.mkDefault -"
    #cpu.intel.updateMicrocode = true;
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    enableAllFirmware = true;
    bluetooth.enable = false;
    graphics = {
      enable = true;
      ## packages for integrated graphics inside Hades
      extraPackages = with pkgs; [
        intel-compute-runtime
  	intel-media-driver
  	vaapiIntel
  	vaapiVdpau
  	libvdpau-va-gl		
      ];
    };	
  };

  ## some packages for managing the radeon GPU inside Hades
  environment.systemPackages = with pkgs; [
    umr
    radeontop
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
