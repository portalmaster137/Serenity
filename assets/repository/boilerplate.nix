# base level inputs, should only ever be self and inputs
{ self, inputs, ... }:

# let bindings
let

  # for foo.bar
  foobar = "barbar";

in

{

  # module name declaration, as well as any required inputs
  flake.modules.nixos.modulename =

    { ... }:

    {

      # import system level module for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # system level options
      programs.foo = {
        bar = "${foobar}";
      };

      # home manager options
      home-manager.users.${username} = {

        # user level options
        programs.foo = {
          bar = "${foobar}";
        };

      };

    };

}
