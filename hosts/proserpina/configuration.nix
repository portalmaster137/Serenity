{ inputs, outputs, config, lib, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
    ./disko-config.nix
    ./network-configuration.nix

    ../../modules/core/
    
  ];

  # Enable swap on luks
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
	    configurationLimit = 5;
      };
      efi = {
        canTouchEfiVariables = true;
        # efiSysMountPoint = "/boot/efi";
      };
    };
    initrd = {
      systemd.enable = true;
      secrets = {
	# "crypto_keyfile.bin" = null;
      };
      luks = {
	# devices."luks-DISK_UUID" = {
          # device = "/dev/disk/by-uuid/DISK_UUID";
        # keyfile = "/crypto_keyfile.bin";
	# };
      };
    };
  };

  services.fstrim.enable = true;
  
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  
  hardware = {
  
    cpu.intel.updateMicrocode = true;
  	enableAllFirmware = false;
  	bluetooth.enable = true;
  	
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
  	  options = "--delete-older-than 2d";
  	  persistent = true;
  	};
  };

}
