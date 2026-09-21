{ self, inputs, ... }:

{

  # defines the hades specific configuration
  flake.nixosConfigurations.hades = inputs.nixpkgs.lib.nixosSystem {

    # modules that comprise the host specific configuration
    modules = with self.nixosModules; [

      # shared system modules
      core

      # host-specific options
      hades
      hadesHardware

      # extra modules to include on host
      terminal
      desktop
      gaming
      virtual-reality

      # users to include on host
      serenity

    ];

  };

}
