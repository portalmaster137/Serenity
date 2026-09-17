{
  self,
  inputs,
  config,
  ...
}:

let

  # default username here
  username = "serenity";

in

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

      # extra modules
      self.modules.nixos.gaming

      # users to include on host
      self.modules.nixos.serenity
      # home manager and home manager imports
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.users.serenity = {
          imports = [
            config.flake.homeModules.desktop
          ];
        };
      }

    ];

  };

}
