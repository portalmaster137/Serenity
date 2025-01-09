{ ... }:

{

  imports = [

    ## Selected host modules for import
    ./hardware.nix # hardware configuration
    ./network.nix # network configuration

    ## Additional core modules to import
    ../../../modules/jellyfin.nix # temporary for config purposes
    ../../../modules/gaming.nix # didnt work in home-manager :(
    ../../../modules/zfs.nix # ZFS config
  ];

}
