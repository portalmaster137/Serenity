{ ... }:

{

  imports = [

    ## Selected host modules for import
    ./hardware.nix # hardware configuration
    ./network.nix # network configuration
    ./syncthing.nix # syncthing configuration
    ./zfs.nix # zfs configuration

    ## Additional core modules to import
    ../../../core/modules/jellyfin.nix
    ../../../core/modules/gaming.nix # didnt work in home-manager :(

  ];

}
