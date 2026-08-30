{ config, ... }:

# let bindings
let

  # xdg variables
  data = config.xdg.dataHome;
  conf = config.xdg.configHome;
  cache = config.xdg.cacheHome;

in

{

  # list of modules to include
  imports = [
    ./programs
    ./kitty.nix
    ./fish.nix
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
}
