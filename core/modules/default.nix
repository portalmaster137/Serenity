{ config, lib, ... }:

{

  imports = [

    ## Semi-modularised config
    ./sync.nix # syncthing and gitwatch settings
    ./misc.nix # stuff that doesn't work in `/home` :(
    ./audio.nix # musnix and ... audio ... config
    ./display.nix # declarations for display management
    (lib.mkIf config.networking.hostName."hades" ./zfs)

  ];

}
