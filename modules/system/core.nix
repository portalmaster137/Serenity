{ self, lib, ... }:

{

  flake.modules.nixos.core = { pkgs, ... }: {

    # other modules to load
    imports = [
      self.nixosModules.audio
      self.nixosModules.packages
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

    # don't touch this
    system.stateVersion = lib.mkDefault "24.11";
    documentation.dev.enable = true;

  };

}
