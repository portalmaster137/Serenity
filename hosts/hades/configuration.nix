{ inputs, outputs, config, lib, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
    # ./disko-config.nix
    # ./network-config.nix
    ../../core/configuration.nix
    
  ];

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
