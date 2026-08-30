{ self, inputs, ... }: {
  flake.nixosConfigurations.hades = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hadesConfiguration
    ];
  };
}
