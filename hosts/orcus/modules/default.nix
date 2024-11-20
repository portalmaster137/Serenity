{ ... }:

{

  imports = [

    ## Selected modules for import
     #./hardware.nix # hardware configuration
    ./network.nix # network configuration
    ./zfs.nix # zfs configuration

    ## Selected core modules for import
    ../../../core/modules/jellyfin.nix

  ];

}
