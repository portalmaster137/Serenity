{ self, inputs, ... }: {

  flake.nixosModules.desktop = { pkgs, ... }: {

    #programs.foo = bar;
    
  };

  flake.homeModules.desktop = { self, inputs, ... }; {
    
    imports = with self.homeModules; [
      niri
      terminal
    ];
    
  };
  
}
