{ ... }:

{
  imports = [
    ## Selected modules for import
    ./zfs.nix # zfs storage config
    ./hardware.nix # hardware config
    ./network.nix # network/internet config
  ];

}
