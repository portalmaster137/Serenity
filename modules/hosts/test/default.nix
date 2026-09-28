{ self, inputs, ... }:

{

  # defines the hades specific configuration
  flake.nixosConfigurations.iso-installer = inputs.nixpkgs.lib.nixosSystem {

    # modules that comprise the host specific configuration
    modules = with self.nixosModules; [

      # shared system modules
      core

      # host-specific options
      install-configuration

      # extra modules to include on host
      terminal
      zfs-support
      virtual-reality
      network-proxy
      virtualisation

      # users to include on host
      #user-options
      serenity

    ];

  };

}
