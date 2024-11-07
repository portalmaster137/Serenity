{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports = [

    ## Import necessary flake modules
     #"${builtins.fetchTarball "<flake module url>"}/module.nix"

    ## Include host specific options
    ./hardware
    ./network

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
      ## and clear junk older than 1 day
      options = "--delete-older-than 1d";

      ## No clue what this does lol.
      persistent = true;
    };
  };

}
