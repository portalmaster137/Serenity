{ ... }:

{
  imports = [
    ## Selected modules for import
    ./zfs.nix # zfs storage config
    ./network.nix # network/internet config
  ];

}
