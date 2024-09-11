{ inputs, outputs, config, lib, pkgs, ... }:

{

  imports = [
    
  ];

  # Enable swap on luks
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
    };
      #systemd-boot = {
        #enable = false;
	    #configurationLimit = 10;
      #};
      grub = {
       enable = true;
       #efiSupport = true;
       #efiInstallAsRemovable = true;
       device = "/dev/sdd";
       useOSProber = true;
       enableCryptodisk = true;
      };
    };
    initrd = {
      systemd.enable = true;
      secrets = {
	    "/boot/crypto_keyfile.bin" = null;
      };
      luks = {
	    #devices."luks-3de671ef-22a3-4f28-9251-a0687ab44f96".keyFile = "/boot/crypto_keyfile.bin";
          # device = "/dev/disk/by-uuid/DISK_UUID";
          # keyfile = "/crypto_keyfile.bin";
	    };
      };
    };

}
