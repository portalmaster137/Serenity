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
    ## semi-modularised config
    ./packages.nix # system-level packages here
    ../home/users # user-level packages here
  ];

  ## crikey !
  time.timeZone = "Australia/Brisbane";
  i18n.defaultLocale = "en_GB.UTF-8";

  ## gotta have sound, this too is common 
  #sound.enable = false;
  hardware.pulseaudio.enable = false;
  services.pipewire = {  
    enable = true;
    #jack.enable = false;
    pulse.enable = true;
    alsa.enable = true;
    #alsa.support32Bit = false;
    #lowLatency.enable = true;
  };

  ## genuinely dunno what these do hey, like isnt sudo
  ## already restricted to @wheel only? & wut is rtkit
  security = {
    rtkit.enable = true;
    sudo.execWheelOnly = true;
  };

  nix.settings = {
    ## use all cores during build
    cores = 0;
    auto-optimise-store = true;
    allowed-users = [ "@wheel" ];
    ## enable flakes uwu
    experimental-features = [
    "nix-command"
    "flakes"
    ];
  };

  ## apparently prevents getting stuck at shutdown
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
  
  ## disable these cuz they cause problems (thx sasha)
  ## see: https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services = {
    networkManager-wait-online.enable = lib.mkForce false;
    systemd-networkd-wait-online.enable = lib.mkForce false;
  };

  ## https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
  
}
