{
  self,
  inputs,
  ...
}:

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
      #self.modules.yazi
      # shell and prompt
      #self.modules.fish
      # version control
      #self.modules.git

    ];

  };

}
