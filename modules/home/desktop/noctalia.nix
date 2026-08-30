{ self, inputs, ... }: {

  perSystem = { pkgs, ... }: {

    # defines a custom noctalia package
    packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {

      # use global packages
      inherit pkgs;

      # use a separate json file to configure
      # nixify this.
      settings = (builtins.fromJSON (builtins.readFile ./noctalia.json)).settings;

    };

  };

}
