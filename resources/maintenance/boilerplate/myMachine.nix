{ inputs, self, ... }: {


  flake.nixosConfigurations.myMachine = inputs.nixpkgs.lib.nixosSystem {

    modules = with self; [
      nixosModules.myMachineModule 
      nixosModules.myFirstModule
    ];

  };


  flake.nixosModules.myMachineModule = { pkgs, ... }: {

    boot.loader.grub.enable = true;

    environment.systemPackages = with self; [
      packages.${pkgs.system}.myPackage
    ];

  };


}
