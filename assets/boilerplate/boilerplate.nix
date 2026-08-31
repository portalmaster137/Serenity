{ self, inputs, ... }:

# let bindings
let

  #foo = bar
  #

in

{

  # nixos module declaration
  flake.modules.nixos.modulename = { ... }: {

    # list of modules to import
    modules = [
      self.modules.nixos.othermodule
    ];
    imports = [
      ./otherfile.nix
    ];

    # options
    programs = { };

  };

  # home manager module declaration
  flake.modules.homeManager.modulename = { ... }: {

    # module imports
    imports = [ ];

    # options
    programs = { };

  };

}
