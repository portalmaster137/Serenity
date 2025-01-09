{ config, lib, ... }:
let hostname = config.networking.hostName;
in {

  imports = [

    ## Semi-modularised config
    ./sync.nix # syncthing and gitwatch settings
    ./misc.nix # stuff that doesn't work in `/home` :(
    ./audio.nix # musnix and ... audio ... config
    ./display.nix # declarations for display management
    (lib.mkIf config.networking.hostName."hades" [ ./zfs ])

  ]; # ++ lib.optionals(hostname == "hades" [ ./zfs ]; ) ;

}
