{
  self,
  inputs,
  config,
  ...
}:
{

  # defines the hades specific config modules
  flake.nixosConfigurations.hades = inputs.nixpkgs.lib.nixosSystem {

    # modules that comprise the host specific module
    modules = [

      # core system modules
      self.nixosModules.coreConfig

      # hades system modules
      self.nixosModules.hadesHardware
      self.nixosModules.hadesConfig

      # home manager and home manager imports
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.backupFileExtension = "bak";
        home-manager.users.serenity = {
          imports = [
            config.flake.homeModules.baseHome
            config.flake.homeModules.hadesHome
          ];
        };
      }

    ];

  };

}
