{ self, inputs, ... }:

{

  # needed for home manager functionality
  imports = [ inputs.home-manager.flakeModules.home-manager ];

  # misc flake-parts configuration
  config = {

    # uarchs to build for
    systems = [ "x86_64-linux" ];

  };

}
