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
    ./packages
    # ./display
    ../home/users

  ];

  ## locale is common across machines
  ## crikey !
  time.timeZone = "Australia/Brisbane";
  i18n.defaultLocale = "en_GB.UTF-8";

  ## gotta have sound, this too is common 
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {  
  	enable = true;
  	jack.enable = true;
  	pulse.enable = true;
  	alsa.enable = true;
  	alsa.support32Bit = true;
    # lowLatency.enable = true;
  };

  ## genuinely dunno what these do hey, like isnt sudo
  ## already restricted to @wheel only? & wut is rtkit
  security = {
  	rtkit.enable = true;
  	sudo.execWheelOnly = true;
  };

  ## settings for nix
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

  ## disable these cuz they cause problems (thx sasha)
  ## see: https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services = {
  	networkManager-wait-online.enable = lib.mkForce false;
  	systemd-networkd-wait-online.enable = lib.mkForce false;
  };

  ## autoupgrades ? disabled for now, need to read into
  # system.autoUpgrade = {
  #	  enable = true;
  #	  channel = "";
  # };
  
  ## https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
  
}
