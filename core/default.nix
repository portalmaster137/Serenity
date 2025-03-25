{ inputs, lib, pkgs, primaryUser, ... }:

{

  imports = [

    ## Not sure wei need the home-manager import here
    inputs.home-manager.nixosModules.home-manager

    ## Semi-modularised config
    ./modules # additional modules to import
    ../home # user-level packages in ../home/programs/
    ../secrets # secrets :shh:

    ## Testing
    ../home/scripts/automount/postActivation.nix

  ];

  ## Make sure this is set !
  system = { stateVersion = "24.11"; };

  ## Crikey !
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

  security = {

    ## Sets sudo auth to @wheel only
    sudo.execWheelOnly = true;

    ## Enables soteria polkit
    ## disabled forNow:tm: - https://github.com/NixOS/nixpkgs/issues/379104
    #soteria.enable = true;

    polkit = {
      enable = true;
      #extraConfig = '' '';
    };

  };

  nix = {
    settings = {
      cores = 0;
      max-jobs = "auto";
      allow-dirty = false;
      auto-optimise-store = true;
      download-buffer-size = [ "268435456" ];
      allowed-users = [ "@wheel" ];
      trusted-users = [ "root" "@wheel" "${primaryUser}" ];
      ## Enable flakes uwu,,, and some other junk idek
      experimental-features =
        [ "pipe-operators" "recursive-nix" "nix-command" "flakes" ];
    };

    gc = {
      ## Automatically run 'nix-collect-garbage'
      automatic = true;
      ## Ever day.
      dates = "daily";
      ## and clear junk older than x days
      options = "--delete-older-than 7d";
      ## https://mynixos.com/nixpkgs/option/nix.gc.persistent
      #persistent = true;
    };

  };

  hardware = {
    ## Enable all firmware modules
    enableAllFirmware = true;
    sensor.hddtemp = {
      enable = true;
      drives = [ "/dev/disk/by-uuid/*" ];
    };
    usbStorage.manageShutdown = true;

  };

  environment.systemPackages = with pkgs; [ man-pages ];

  documentation = {
    dev.enable = true;
    man.generateCaches = true;
    #nixos.includeAllModules = true;
  };

  ## Apparently prevents getting stuck at shutdown
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";

  ## Disable these cuz they cause problems (thx sasha)
  ## see: https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services = {
    networkManager-wait-online.enable = lib.mkForce false;
    systemd-networkd-wait-online.enable = lib.mkForce false;
  };

}
