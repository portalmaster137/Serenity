{ pkgs, config, ... }:

let

  homedir = config.home.homeDirectory;

   #hostname = config.system.nixos.distroId;

  nixsyu = pkgs.writeShellScriptBin "nixsyu" ''
    cd {$homedir}/flakes/nixdots/ && sudo nix flake update &&
    sudo nixos-rebuild switch --upgrade-all --flake {$homedir}/flakes/nixdots#{$hostname} --show-trace
    && sudo nix-collect-garbage -d && sudo nix-store --optimise
  '';

  nixrb = pkgs.writeShellScriptBin "nixrb" ''
    sudo nixos-rebuild switch --flake {$homedir}/flakes/nixdots#{$hostname}
  '';

  nixrbt = pkgs.writeShellScriptBin "nixrbt" ''
    sudo nixos-rebuild switch --flake {$homedir}/flakes/nixdots#{$hostname} --show-trace
  '';

  nixupg = pkgs.writeShellScriptBin "nixupg" ''
    sudo nixos-rebuild switch --upgrade-all --flake {$homedir}/flakes/nixdots#{$hostname} --show-trace
  '';

  nixcb = pkgs.writeShellScriptBin "nixcb" ''
    sudo /run/current-system/bin/switch-to-configuration boot
  '';

  nixgc = pkgs.writeShellScriptBin "nixgc" ''
    cd {$homedir}/flakes/nixdots/nixos && sudo nix-collect-garbage -d
  '';

  nixu = pkgs.writeShellScriptBin "nixu" ''
    cd {$homedir}/flakes/nixdots && sudo nix flake update
  '';

  nixe = pkgs.writeShellScriptBin "nixe" ''
    $EDITOR {$homedir}/flakes/nixdots/
  '';

in {

  home.packages = with pkgs; [
    nixsyu
    nixrbt
    nixrb
    nixupg
    nixu
    nixe
    nixgc
    nixcb
  ];

}

