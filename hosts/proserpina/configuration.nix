{ inputs, outputs, config, pkgs, lib, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../configuration.nix
    ];

  # Enable swap on luks
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    initrd = {
      luks.devices."luks-c2b8b1cb-6d01-4e7c-a659-1fcf01618c41" = {
        device = "/dev/disk/by-uuid/c2b8b1cb-6d01-4e7c-a659-1fcf01618c41";
        # keyfile = "/crypto_keyfile.bin";
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
      enable = true;
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
