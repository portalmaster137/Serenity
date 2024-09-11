{ inputs, outputs, config, lib, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-config.nix
    # "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
    # ./disko-config.nix
    # ./network-config.nix
    ../../core/configuration.nix
    
  ];

  # powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

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

}
