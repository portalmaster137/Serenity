{ self, inputs, ... }:

{

  # terminal supermodule
  flake.nixosModules.terminal = { pkgs, ... }: {

    # list of modules to include
    imports = [

      # home manager
      inputs.home-manager.nixosModules.home-manager

      # terminal emulator
      self.nixosModules.kitty

      # text editor
      self.nixosModules.helix

      # file manager
      #self.nixosModules.yazi

      # shell and prompt
      #self.nixosModules.fish

      # system monitor
      self.nixosModules.btop

      # version control
      self.nixosModules.git

    ];

  };

}
