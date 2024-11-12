{ inputs, outputs, modulesPath, lib, config, pkgs, ... }:

{
  imports = [

    ## Selected modules for import
    ./zfs.nix # zfs storage config
     #./disko.nix # disk/partition config
    ./network.nix # network/internet config
     #./syncthing.nix # syncthing config

  ];

}
