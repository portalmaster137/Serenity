{ ... }:

{

  imports = [

    ## Selected host modules for import
    ./hardware.nix # hardware configuration
    ./network.nix # network configuration
    #./zfs.nix # zfs configuration

    ## Additional core modules to import
    ../../../core/modules/jellyfin.nix # temporary for config purposes
    ../../../core/modules/gaming.nix # didnt work in home-manager :(

  ];

}
