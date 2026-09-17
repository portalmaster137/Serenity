{ self, inputs, ... }: {

  flake.nixosModules.desktop = {

    # modules to include
    imports = with self.nixosModules; [
      #greeter
      niri
      noctalia
      #stylix
    ];

    #programs.foo = bar;

  };

}
