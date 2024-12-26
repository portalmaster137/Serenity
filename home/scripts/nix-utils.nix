{ pkgs, hostname, flakePath, ... }:

let

  nixrb = pkgs.writeShellScriptBin "nixrb" ''
    cd ${flakePath} && sudo nixos-rebuild switch --flake .#${hostname} --show-trace
  '';

  nixcb = pkgs.writeShellScriptBin "nixcb" ''
    sudo /run/current-system/bin/switch-to-configuration boot
  '';

  nixgc = pkgs.writeShellScriptBin "nixgc" ''
    cd ${flakePath} && sudo nix-collect-garbage -d
  '';

  nixu = pkgs.writeShellScriptBin "nixu" ''
    cd ${flakePath} && sudo nix flake update
  '';

in {
  home.packages = [
    nixrb
    nixcb
    nixgc
    nixu
  ];
}

