{ lib, inputs, pkgs, user, ... }:

{

  imports = [
    # Not sure we need the home-manager import here
    inputs.home-manager.nixosModules.home-manager
    # Semi-modularised config
    ../home # user-level/additional packages
    # Shared modules to import
    ./audio.nix # musnix and audio options
    ./display.nix # base display and output options
    ./regreet.nix # login manager
    ./packages.nix # core/essential packages
  ];

  # Make sure this is set !
  system = { stateVersion = "24.11"; };

  # Core security options
  security = {
    sudo.execWheelOnly = true; # sets sudo auth to @wheel only
    polkit.enable = true; # enables system polkit ???
  };

  # Settings for the nix package manager and daemon
  nix = {
    settings = {
      cores = 12; # sets nix to use most available cores during rebuild
      max-jobs = "auto"; # automatically determines max job count
      allow-dirty = false; # refuses to allow rebuilds when git tree is dirty
      auto-optimise-store = true; # automatically optimised nix store on rebuild
      allowed-users = [ "@wheel" ]; # restricts `nix` command to @wheel
      trusted-users = [ # adds root, @wheel, and ${primaryUser} to trusted users
        "root"
        "@wheel"
        "${user}"
      ]; 
      experimental-features = [ # enable flakes uwu,,, and some other junk idek
        "pipe-operators" # who tf knows
        "recursive-nix" # honestly I cannot rember
        "nix-command" # useful nya
        "flakes" # flakes are vv important nya
      ];
    };
    # Garbage collection
    gc = {
      automatic = true; # do garbage collection automagically
      dates = "daily"; # every day
      options = "--delete-older-than 3d"; # and clear junk older than x days
      #persistent = true; # https://mynixos.com/nixpkgs/option/nix.gc.persistent
    };
  };

  # Hardware settings
  hardware = {
    enableAllHardware = true; # enables all hardware modules
    enableAllFirmware = true; # enables all firmware modules
    enableRedistributableFirmware = true; # enables redistributables
    usbStorage.manageShutdown = true; # graceful usb storage shutdown 
    sensor.hddtemp = { 
      enable = true; # enables temperature readings for mechanical drives
      drives = [ "/dev/disk/by-uuid/*" ]; # tries to find drives with sensors by uuid
    };
  };

  # Manual pages and caching
  environment.systemPackages = with pkgs; [ man-pages ]; # adds manual to system packages
  documentation = {
    dev.enable = true; # enables development documentation
    man.cache.enable = true; # generates manual caches to save rebuild time
    nixos.includeAllModules = true; # unsure lol
  };

  # Locale settings
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

}
