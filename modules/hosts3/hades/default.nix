{ self, inputs, config, ... }: {

  flake.nixosConfigurations.hades = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hadesHardware
      self.nixosModules.coreConfiguration

      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.backupFileExtension = "bak";
        home-manager.users.serenity = {
          imports = [
            config.flake.homeModules.base
            config.flake.homeModules.hadesHome
          ];
        };
      }

    ];
  };
}
