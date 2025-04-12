{ inputs, lib, pkgs, primaryUser, ... }:

{

  imports = [

    ## Not sure wei need the home-manager import here
    inputs.home-manager.nixosModules.home-manager

    ## Semi-modularised config
    ../home # user-level packages in ../home/programs/
    ../secrets # secrets :shh:

    ## Shared modules to import
    ./audio.nix
    ./display.nix
    ./regreet.nix
    ./packages.nix

  ];

  ## Core security options
  security = {
    sudo.execWheelOnly = true; # sets sudo auth to @wheel only
    #soteria.enable = true; # enables soteria polkit
    # - disabled forNow:tm: - https://github.com/NixOS/nixpkgs/issues/379104
    polkit = { # enables system polkit ???
      enable = true;
      #extraConfig = '' '';
    };
  };

  ## test line

  ## Settings for the nix package manager and daemon
  nix = {
    settings = {
      cores = 0; # sets nix to use all available cores during rebuild
      max-jobs = "auto"; # automatically determines max job count
      allow-dirty = false; # refuses to allow rebuilds when git tree is dirty
      auto-optimise-store = true; # automatically optimised nix store on rebuild
      download-buffer-size = [
        "268435456"
      ]; # increased download buffer as it caused issues previously
      allowed-users = [ "@wheel" ]; # restricts `nix` command to @wheel
      trusted-users = [
        "root"
        "@wheel"
        "${primaryUser}"
      ]; # adds root, @wheel, and ${primaryUser} to trusted users
      experimental-features = [ # Enable flakes uwu,,, and some other junk idek
        "pipe-operators" # who tf knows
        "recursive-nix" # honestly I cannot rember
        "nix-command" # useful nya
        "flakes" # flakes are vv important nya
      ];

      ## Substiters for packages either not in or out of date in nixpkgs
      substituters = [ ];
      trusted-public-keys = [ ];
    };

    ## Nix garbage collection
    gc = {
      automatic = true; # do garbage collection automagically
      dates = "daily"; # every day
      options = "--delete-older-than 7d"; # and clear junk older than x days
      #persistent = true; # https://mynixos.com/nixpkgs/option/nix.gc.persistent
    };
  };

  ## Hardware settings
  hardware = {
    enableAllFirmware = true; # enables all firmware modules
    sensor.hddtemp = { # enables temperature readings for mechanical drives
      enable = true;
      drives =
        [ "/dev/disk/by-uuid/*" ]; # tries to find drives with sensors by uuid
    };
    usbStorage.manageShutdown = true; # shrugge
  };

  ## Manual pages and caching
  environment.systemPackages = with pkgs;
    [ man-pages ]; # adds manual pages to system packages for ease of access
  documentation = {
    dev.enable = true; # enables development documentation
    man.generateCaches =
      true; # generates caches for manuals to save rebuild time
    #nixos.includeAllModules = true;
  };

  ## SystemD tweaks
  systemd = {
    extraConfig =
      "DefaultTimeoutStopSec=10s"; # apparently prevents getting stuck at shutdown
    services = { # Disable these cuz they cause problems (thx sasha)
      # see: https://github.com/NixOS/nixpkgs/issues/180175
      networkManager-wait-online.enable = lib.mkForce false;
      systemd-networkd-wait-online.enable = lib.mkForce false;
    };
  };

  ## Crikey !
  ## Don't forget to set your& locale settings !
  time.timeZone = "Australia/Brisbane";
  i18n = {
    defaultLocale = "en_AU.UTF-8";
    extraLocaleSettings = {
      LC_NAME = "en_AU.UTF-8";
      LC_TIME = "en_AU.UTF-8";
      LC_PAPER = "en_AU.UTF-8";
      LC_ADDRESS = "en_AU.UTF-8";
      LC_MONETARY = "en_AU.UTF-8";
      LC_TELEPHONE = "en_AU.UTF-8";
      LC_MEASUREMENT = "en_AU.UTF-8";
      LC_IDENTIFICATION = "en_AU.UTF-8";
    };
  };

  ## Make sure this is set !
  system = { stateVersion = "24.11"; };

}
