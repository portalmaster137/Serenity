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

    # home-manager
    inputs.home-manager.nixosModules.home-manager

    # also split up configuration.nix and import pieces:
    ../home/users
    ./packages.nix

  ];

  security = {
  	rtkit.enable = true;
  	sudo.execWheelOnly = true;
  };

  time.timeZone = "Australia/Brisbane";
  i18n.defaultLocale = "en_GB.UTF-8";

  nixpkgs = {
    # add overlays here
    overlays = [
      # to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # configure nixpkgs instance
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
      ];
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  nix.settings = {
    cores = 0;
    auto-optimise-store = true;
    allowed-users = [ "@wheel" ];
    experimental-features = [
    "nix-command"
    "flakes"
    ];
  };

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

  # disable these cuz they cause problems
  # see: https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services = {
  	networkManager-wait-online.enable = lib.mkForce false;
  	systemd-networkd-wait-online.enable = lib.mkForce false;
  };


  # system.autoUpgrade = {
  	# enable = true;
  	# channel = "";
  # };
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
