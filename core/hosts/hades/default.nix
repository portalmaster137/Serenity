{ inputs, outputs, config, lib, pkgs, ... }:

{
  imports = [
    ## Include the results of the hardware scan.
    ./hardware.nix
     #"${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
    ./network.nix
    ../../config.nix
    
  ];

  nix = {
     #settings = {
     #};
    gc = {
      ## Every day, automatically collect garbage older than 10 days
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 3d";
      persistent = true;
    };
  };

}
