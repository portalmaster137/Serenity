{ inputs, outputs, config, lib, pkgs, ... }:

{
  imports = [

    ## Import necessary flake modules
     #"${builtins.fetchTarball "<flake module url>"}/module.nix"

    ## Include host specific options
    ./hardware.nix
    ./network.nix

    ## Include core config options
    ../../config.nix
    
  ];

  nix = {

     #settings = {
     #};

    gc = {
      ## Automatically run 'nix-collect-garbage',
      automatic = true;
      ## every day,
      dates = "daily";
      ## and clear junk older than 3 days
      options = "--delete-older-than 3d";

      ## No clue what this does lol.
      persistent = true;
    };
  };

}
