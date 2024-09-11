{ inputs, outputs, config, lib, pkgs, ... }:

{

  imports = [
    
  ];

  # Enable swap on luks
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
        #efiSysMountPoint = "/boot/efi";
      }; 
      #systemd-boot = {
        #enable = false;
	    #configurationLimit = 10;
      #};
      grub = {
        enable = true;
        #efiSupport = true;
        #efiInstallAsRemovable = true;
        device = "/dev/sda";
        #useOSProber = true;
        enableCryptodisk = true;
      };  
    };

  };

}
