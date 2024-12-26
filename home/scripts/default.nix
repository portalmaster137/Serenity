{ pkgs, config, ... }:

{
  imports = [
    ./automount
    ./startup.nix
    ./desktop.nix
    ./nix-utils.nix
  ];
}
