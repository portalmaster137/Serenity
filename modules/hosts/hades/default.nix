{ self, inputs, ... }:

{

  # defines the hades specific configuration
  flake.nixosConfigurations.hades = inputs.nixpkgs.lib.nixosSystem {

    # modules that comprise the host specific configuration
    modules = with self.nixosModules; [

      # host-specific options
      hades
      hadesHardware

      # users to include on host
      serenity

      # extra modules to include on host
      terminal
      desktop

    ];

  };

}
