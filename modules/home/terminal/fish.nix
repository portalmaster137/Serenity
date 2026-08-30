{ self, inputs, ... }: {

  perSystem = { pkgs, ... }: {

    # defines a custom fish package
    packages.myFish = inputs.wrapper-modules.wrappers.fish.wrap {

      settings = {
        foo = bar;
      };

    };

  };

}
