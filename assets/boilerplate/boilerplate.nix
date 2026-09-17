{ self, inputs, ... }:

# let bindings
let

  # for foobar
  #foo = bar

in

{

  # nixos module declaration
  flake.modules.nixos.modulename = { ... }: {

    # list of modules to import
    modules = [
      self.modules.nixos.othermodule
    ];

    # for home manager functionality
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    # nixos options
    programs = {
      foo = {
        bar = true;
      };
    };

    # home manager options
    home-manager.users.${username} = {

      # program settings
      programs = {

        foo = {
          bar = true;
        };

      };

    };

  };

}
