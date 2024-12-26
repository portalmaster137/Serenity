{ pkgs, config, flakePath, ... }:

let

  hostname = "${config.networking.hostName}";

  nixsyu = pkgs.writeShellScriptBin "nixsyu" ''
    cd ${flakePath} && sudo nix flake update && sudo nixos-rebuild switch --upgrade-all --flake .#${hostname} --show-trace && sudo nix-collect-garbage -d && sudo nix-store --optimise
  '';

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
    nixsyu
    nixrb
    nixcb
    nixgc
    nixu
  ];
}

