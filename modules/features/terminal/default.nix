{ self, inputs, ... }:

{

  # terminal supermodule
  flake.nixosModules.terminal =

    { pkgs, ... }:

    {

      # list of modules to include
      imports = [

        # home manager
        inputs.home-manager.nixosModules.home-manager

        # text editor
        self.nixosModules.helix

        # for showing off, lol
        self.nixosModules.fetch

        # file manager
        self.nixosModules.yazi

        # shell and prompt
        self.nixosModules.fish

        # system monitor
        self.nixosModules.btop

        # version control
        self.nixosModules.git


        # C Development Environment
        self.nixosModules.cdevenv

        self.nixosModules.nixd
      ];

    };

  # to make kitty an optional include
  flake.nixosModules.terminal-emulator =

    { pkgs, ... }:

    {

      imports = [
        self.nixosModules.kitty
      ];

    };

}
