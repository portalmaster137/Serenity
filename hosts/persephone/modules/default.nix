{ ... }:

{

  imports = [

    ## Selected host modules for import
    ./hardware.nix # hardware configuration
    ./network.nix # network configuration

    ## Selected core modules for import
    ../../../core/modules/display.nix # display stuff
    ../../../core/modules/regreet.nix # regreet customisation
    ../../../core/modules/desktop.nix # didnt work in home-manager :(
    ../../../core/modules/audio.nix # sound configuration

  ];

}
