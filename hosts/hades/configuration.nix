{ inputs, outputs, config, lib, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
    # ./disko-config.nix
    # ./network-configuration.nix
    ../../core/configuration.nix
    
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
       #enable = true;
       #efiSupport = true;
       #efiInstallAsRemovable = true;
       #device = "/dev/sdd";
       #useOSProber = true;
       #enableCryptodisk = true;
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

  services.fstrim.enable = true;
  
  # powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  
  hardware = {
  
    cpu.intel.updateMicrocode = true;
  	enableAllFirmware = true;
  	bluetooth.enable = false;
  	
  	opengl = {
  	  enable = true;
  	  extraPackages = with pkgs; [
  	    intel-compute-runtime
  	    intel-media-driver
  	    vaapiIntel
  	    vaapiVdpau
  	    libvdpau-va-gl		
      ];
  	};
  	
  };
  
  nix = {
  	# settings = {
  	# };
  	gc = {
  	  automatic = true;
  	  dates = "daily";
  	  options = "--delete-older-than 10d";
  	  persistent = true;
  	};
  };

  environment.systemPackages = with pkgs; [
    umr
    radeontop
    radeontools
    radeon-profile
    amdgpu_top
  ];

}
