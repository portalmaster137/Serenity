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

    # modules that comprise the host specific configuration
    modules = with self.nixosModules; [

      # actual desktop module set defined below
      hades

    ];

  };

  flake.nixosModules.hades =
    {
      pkgs,
      inputs,
      config,
      ...
    }:
    {
      imports = with self.nixosModules; [

        # core system modules
        core

        # hades system modules
        hades-hardware

        # extra modules
        gaming

        # users to include on host
        serenity

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
