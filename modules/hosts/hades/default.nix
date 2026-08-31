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
      self.nixosModules.core

      # hades system modules
      self.nixosModules.hades
      self.nixosModules.hades-hardware

      # home manager and home manager imports
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.backupFileExtension = "bak";
        home-manager.users.serenity = {
          imports = [
            config.flake.homeModules.core-home
            #config.flake.homeModules.hades-home
          ];
        };
      }

    ];

  };

}
