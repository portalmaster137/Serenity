{ self, inputs, ... }:

{

  flake.nixosModules.core = { config, pkgs, ... }:

  let

    # flakepath for QoL
    flakePath = config.userOptions.flakePath

    # username
    username = config.userOptions.username

  in

  {

    # other modules to load
    imports = [

      # core packages to load
      self.nixosModules.core-packages

      # home manager functionality
      inputs.home-manager.nixosModules.home-manager

    ];

    # extra features
    nix.settings.experimental-features = [
      
      # flake based config requires flakes
      "flakes"
      
      #fancier nix usage
      "nix-command"
      
    ];

    # compresses half the ram for use as swap
    zramSwap.enable = true;

    # locale settings
    i18n = {
      defaultLocale = "en_AU.UTF-8";
      supportedLocales = [
        "en_AU.UTF-8/UTF-8"
        "en_US.UTF-8/UTF-8"
      ];
    };

    # meanjin time
    time.timeZone = lib.mkDefault "Austrlia/Brisbane";

    # home manager settings
    home-manager = {
      verbose = true;
      overwriteBackup = true;
      backupFileExtension = ".bak";
      useGlobalPkgs = true;
      useUserPackages = true;
      users.${username} = {
        home.stateversion = "24.11";
        nixpkgs.config.allowUnfree = true;
      };
    };

    # don't touch this
    system.stateVersion = lib.mkDefault "24.11";
    documentation.dev.enable = true;

  };

}
