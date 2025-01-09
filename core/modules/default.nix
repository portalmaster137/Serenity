{ ... }:

{

  imports = [

    ## Semi-modularised config
    ./sync.nix # syncthing settings
    ./misc.nix # stuff that doesn't work in `/home` :(
    ./audio.nix # musnix and ... audio ... config
    ./display.nix # declarations for display management

  ];

}
