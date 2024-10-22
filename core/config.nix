{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ## Semi-modularised config
    ./packages.nix # system-level packages here
    ../home/users # user-level packages here
  ];

  ## Crikey !
  time.timeZone = "Australia/Brisbane";
  i18n.defaultLocale = "en_GB.UTF-8";

  ## Genuinely dunno what these do hey, like isnt sudo
  ## already restricted to @wheel only? & wut is rtkit
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo.execWheelOnly = true;
  };

  nix.settings = {
    ## Use all cores during build
    cores = 0;
    max-jobs = "auto";
    allow-dirty = false;
    auto-optimise-store = true;
    download-buffer-size = [ "268435456" ];
    allowed-users = [ "@wheel" ];
    ## Enable flakes uwu
    experimental-features = [
      "recursive-nix"
      "nix-command"
      "flakes"
    ];
  };

  ## Apparently prevents getting stuck at shutdown
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
  
  ## Disable these cuz they cause problems (thx sasha)
  ## see: https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services = {
    networkManager-wait-online.enable = lib.mkForce false;
    systemd-networkd-wait-online.enable = lib.mkForce false;
  };

  ## https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
  
}
