{ self, lib, ... }:

{

  flake.nixosModules.coreConfig = { pkgs, ... }: {

    # other modules to load
    imports = [
      self.nixosModules.audioConfig
      self.nixosModules.nixConfig
      self.nixosModules.corePackages
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
