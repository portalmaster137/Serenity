{ pkgs, config, ... }:

{
  imports = [
    ./startup.nix
    ./desktop.nix
    ./nix-utils.nix
  ];
}
