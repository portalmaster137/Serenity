{ config, lib, ... }:
let hostname = config.networking.hostName;
in {

  imports = [

    ## Semi-modularised config
    ./sync.nix # syncthing and gitwatch settings
    ./misc.nix # stuff that doesn't work in `/home` :(
    ./audio.nix # musnix and ... audio ... config
    ./display.nix # declarations for display management
  ];
}
