{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports = [
    ## Include the results of the hardware scan.
    ./hardware.nix
     #${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
    ./network.nix
    ../../config.nix
    
  ];

  ## Enable swap on luks
  boot = {

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

    initrd = {
      systemd.enable = true;
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

  };

  services.fstrim.enable = true;

  powerManagement = {
    enable = true;
    powertop.enable = true;
     #cpuFreqGovernor = Lib.mkDefault "powersave";
     #cpufreq = {
       #min = 80000;
       #max = 2000000;
     #};
  };

  environment.memoryAllocator.provider = "graphene-hardened-light";

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
     #settings = {
     #};
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 2d";
      persistent = true;
    };
  };

  system.stateVersion = "23.11";
}
