{ self, inputs, ... }: {

  flake.nixosModules.desktop = {

    # modules to include
    imports =
      with self.nixosModules;
      [
        #greeter
        niri
        noctalia
        #stylix
      ]
      ++ [ inputs.home-manager.nixosModules.home-manager ];

    #programs.foo = bar;

  };

}
