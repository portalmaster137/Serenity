{ inputs, outputs, config, pkgs, lib, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
      ./disko-config.nix
      ./hardware-configuration.nix
      ../../configuration.nix
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

  networking = {
    hostName = "proserpina"; # Define your hostname
  };

  services = {

    syncthing = {
      enable = false;
      dataDir = "/home/serenity/";
      configDir = "/home/serenity/.config/syncthing";
      user = "serenity";
      settings = {
      
        devices = {
          # hades.id = "$DEVICE_ID";
          # hecate.id = "$DEVICE_ID";
          # proserpina.id = "$DEVICE_ID";
        };
        
        folders = {
          # "$FOLDER_ID" = {
            # path = "/home/serenity/Documents/Notes";
            # devices = [ "hecate" "hades" ];
          # };

        };
      };
    };
  };
  
}
