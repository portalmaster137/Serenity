{ inputs, outputs, config, lib, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-config.nix
    # "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
    ./network-config.nix
    ../../config.nix
    
  ];

  services.fstrim.enable = true;

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
