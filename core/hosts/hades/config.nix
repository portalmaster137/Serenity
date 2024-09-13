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

  nix = {
    #settings = {
    #};
    gc = {
      ## every day, automatically collect garbage older than 10 days
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 10d";
      persistent = true;
    };
  };

}
