{ self, inputs, ... }: {

  perSystem = { pkgs, ... }: {

    # defines a custom git package
    packages.myGit = inputs.wrapper-modules.wrappers.git.wrap {

      settings = {
        foo = bar;
      };

    };

  };

}
