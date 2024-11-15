{ pkgs, config, ... }:

let
  homedir = config.home.homeDirectory;

  hostname = config.networking.hostName;

  nixsyu = pkgs.writeShellScriptBin "nix-complete-upgrade" ''
    cd ${homedir}/flakes/nixdots/ && sudo nix flake update &&
    sudo nixos-rebuild switch --upgrade-all --flake ${homedir}/flakes/nixdots#${hostname} --show-trace
    && sudo nix-collect-garbage -d && sudo nix-store --optimise
  '';

  nixrb = pkgs.writeShellScriptBin "nix-rebuild" ''
    sudo nixos-rebuild switch --flake ${homedir}/flakes/nixdots#${hostname}
  '';

  nixrbt = pkgs.writeShellScriptBin "nix-rebuild-trace" ''
    sudo nixos-rebuild switch --flake ${homedir}/flakes/nixdots#${hostname} --show-trace
  '';

  nixupg = pkgs.writeShellScriptBin "nix-upgrade" ''
    sudo nixos-rebuild switch --upgrade-all --flake ${homedir}/flakes/nixdots#${hostname} --show-trace
  '';

  nixcb = pkgs.writeShellScriptBin "nix-cb" ''
    sudo /run/current-system/bin/switch-to-configuration boot
  '';

  nixgc = pkgs.writeShellScriptBin "nix-gc" ''
    cd ${homedir}/flakes/nixdots/nixos && sudo nix-collect-garbage -d
  '';

  nixu = pkgs.writeShellScriptBin "nix-update" ''
    cd ${homedir}/flakes/nixdots && sudo nix flake update
  '';

  nixe = pkgs.writeShellScriptBin "nix-edit" ''
    $EDITOR ${homedir}/flakes/nixdots/
  '';

in {

  home.packages = with pkgs; [
    nix-complete-upgrade
    nix-rebuild-trace
    nix-rebuild
    nix-upgrade
    nix-update
    nix-edit
    nix-gc
    nix-cb
  ];

}

