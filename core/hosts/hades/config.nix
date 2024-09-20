{ inputs, outputs, config, lib, pkgs, ... }:

{
  imports = [
    ## Include the results of the hardware scan.
    ./hardware.nix
     #"${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
    ./network.nix
    ../../config.nix
    
  ];

  ## trim to keep SSDs healthy-ish
  services.fstrim.enable = true;

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
  
    cpu.intel.updateMicrocode = true;

    enableAllFirmware = false;

     #bluetooth.enable = true;	

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
      ## every day, automatically collect garbage older than 10 days
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 3d";
      persistent = true;
    };
  };

}
