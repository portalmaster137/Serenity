{ inputs, self, ... }: {

  imports = [

    # necessary for home manager functionality
    inputs.home-manager.flakeModules.home-manager
    self.nixosModules.userOptions

  ];

  # misc flake-parts configuration
  config = {

    # uarchs to build for
    systems = [
      "x86_64-linux"
    ];

  };

}
