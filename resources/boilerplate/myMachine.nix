{ inputs, self, ... }: {

  # module declaration
  flake.nixosConfigurations.myMachine = inputs.nixpkgs.lib.nixosSystem {

    # modules to import
    modules = with self; [
      nixosModules.myMachineModule
      nixosModules.myFirstModule
    ];

  };

  # module declaration
  flake.nixosModules.myMachineModule = { pkgs, ... }: {

    # options declarations
    boot.loader.grub.enable = true;

    # packages to import
    environment.systemPackages = with self; [
      packages.${pkgs.system}.myPackage
    ];

  };

}
