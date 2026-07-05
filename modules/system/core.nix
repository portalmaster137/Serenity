{ self, lib, ... }:
# default configuration shared by all hosts
{
  flake.nixosModules.coreConfig = { pkgs, ... }: {
    imports = [
      self.nixosModules.audioConfig
      self.nixosModules.nixConfig
    ];

    documentation.dev.enable = true;

    i18n = {
      defaultLocale = "en_AU.UTF-8";
      # saves space
      supportedLocales = [
        "en_AU.UTF-8/UTF-8"
        "en_US.UTF-8/UTF-8"
      ];
    };

    # don't touch this
    system.stateVersion = lib.mkDefault "24.11";

    time.timeZone = lib.mkDefault "Australia/Brisbane";

    # compresses half the ram for use as swap
    zramSwap.enable = true;
  };
}
