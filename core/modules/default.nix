{ ... }:

{

imports = [

    ## Semi-modularised config
    ./jellyfin.nix
    ./regreet.nix
    ./desktop.nix # stuff that doesn't work in home-manager :(
    ./display.nix # declarations for display management
    ./gaming.nix # for gaming stuff, ideally would be in home/
  ];

}
