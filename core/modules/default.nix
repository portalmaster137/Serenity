{ ... }:

{

  imports = [

    ## Semi-modularised config
    ./misc.nix # stuff that doesn't work in `/home` :(
    ./audio.nix # musnix and ... audio ... config
    ./display.nix # declarations for display management

  ];

}
