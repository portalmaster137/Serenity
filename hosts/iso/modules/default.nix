{ ... }:

{

  imports = [

    ## Selected modules for import
    ./network.nix # network/internet config

    ## Selected core modules for import
    ../../../core/modules/display.nix # display stuff
    ../../../core/modules/regreet.nix # regreet customisation
    ../../../core/modules/desktop.nix # didnt work in home-manager :(

  ];

}
