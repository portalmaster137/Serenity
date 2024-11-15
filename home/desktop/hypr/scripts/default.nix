{ pkgs, config, ... }:

{
  imports = [
    ./startup.nix
    ./brightness.nix
    ./screenshot.nix
    ./nix-utils
    ./misc.nix
  ];
}
