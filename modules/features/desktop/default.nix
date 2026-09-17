{ self, inputs, ... }: {

  flake.nixosModules.desktop = {

    # modules to include
    imports = [
      #greeter
      self.nixosModules.niri
      self.nixosModules.noctalia
      #stylix

      # for home manager functionality
      inputs.home-manager.nixosModules.home-manager

      # home manager modules for niri and noctalia
      #inputs.niri.homeModules.niri
      #inputs.noctalia.homeModules.default
    ];

    #programs.foo = bar;

  };

}
