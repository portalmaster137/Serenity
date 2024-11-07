{ lib, config, pkgs, modulesPath, ... }:

{
  imports = [ 

    ## Hardware config
    ./config.nix

    ## Disko config, should eventually let us nuke our boot drive and reinstall
    ## with zero worries.
     #./disko.nix # broken for now

    ## ZFS module, separated to help keep us sane while we set it up lol
    ./zfs.nix

  ];

}
