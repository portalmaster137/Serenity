{ ... }:

{

  imports = [

    ## Selected modules for import
     #./hardware.nix # hardware configuration
    ./network.nix # network configuration
    ./zfs.nix # zfs configuration

    ## Selected core modules for import
    ../../../core/modules/audio.nix
    ../../../core/modules/display.nix
    ../../../core/modules/desktop.nix
    ../../../core/modules/jellyfin.nix

  ];

}
