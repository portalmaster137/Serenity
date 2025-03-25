{ ... }:

{
  imports = [
    ./startup.nix # Programs and scripts executed upon entering desktop environments
    ./desktop.nix # Programs and scripts essential to operating desktop environments
    ./battery.nix # Script for interfacing with batteries present on certain devices
    ./nix-utils.nix # Programs and scripts for interacting with NixOS infrastructure
  ];
}
