{ self, inputs, ... }:

# let bindings
let

  # xdg variables
  data = config.xdg.dataHome;
  conf = config.xdg.configHome;
  cache = config.xdg.cacheHome;

in

{

  # terminal supermodule
  flake.homeModules.terminal = { config, pkgs, ... }: {

    # list of modules to include
    imports = [

      # terminal emulator
      self.modules.kitty
      # text editor
      self.modules.helix
      # file manager
      self.modules.yazi
      # shell and prompt
      self.modules.fish
      # version control
      self.modules.git

    ];

    # environment variables
    home.sessionVariables = {

      # clean up ~
      LESSHISTFILE = "${cache}/less/history";
      LESSKEY = "${conf}/less/lesskey";

      WINEPREFIX = "${data}/wine";
      XAUTHORITY = "$XDG_RUNTIME_DIR/Xauthority";

      EDITOR = "helix";
      DIRENV_LOG_FORMAT = "";

      # auto-run programs using nix-index-database
      NIX_AUTO_RUN = "1";
    };

  };

}
