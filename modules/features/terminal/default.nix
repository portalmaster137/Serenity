{
  self,
  inputs,
  config,
  ...
}:

# let bindings
let

  # xdg variables
  data = config.xdg.dataHome;
  conf = config.xdg.configHome;
  cache = config.xdg.cacheHome;

in

{

  # terminal supermodule
  flake.nixosModules.terminal = { pkgs, ... }: {

    # list of modules to include
    imports = with self.nixosModules; [

      # terminal emulator
      kitty
      # text editor
      helix
      # file manager
      #self.modules.yazi
      # shell and prompt
      #self.modules.fish
      # version control
      #self.modules.git

    ];

  };

}
