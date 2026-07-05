{ self, inputs, ... }: {

  perSystem = { pkgs, ... }: {

    packages.myKitty = inputs.wrapper-modules.wrappers.kitty.wrap {
      settings = {
        foo = bar;
      };
    };

  };

}
