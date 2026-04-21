{ self, inputs, ... }: {

  perSystem = { pkgs, ... }: {

    packages.myYazi = inputs.wrapper-modules.wrappers.yazi.wrap {
      settings = {
        foo = bar;
      };
    };

  };

}
