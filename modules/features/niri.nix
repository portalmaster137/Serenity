{ self, inputs, ... }: {

  perSystem = { pkgs, ... }: {

    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      settings = {
        foo = bar;
      };
    };

  };

}
