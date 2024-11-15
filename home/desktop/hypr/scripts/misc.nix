{ pkgs, config, ... }:

let
  homedir = config.home.homeDirectory;

  menu = pkgs.writeShellScriptBin "menu" ''
    if pgrep wofi; then
    	pkill wofi
    else
    	${pkgs.wofi}/bin/wofi --show drun
    fi
  '';

  powermenu = pkgs.writeShellScriptBin "powermenu" ''
    if pgrep wlogout; then
    	pkill wlogout
    else
      ${pkgs.wlogout}/bin/wlogout
    fi
  '';

  vault = pkgs.writeShellScriptBin "vault" ''
    nvim $HOME/Nextcloud/obsidian
  '';

in { home.packages = with pkgs; [ menu powermenu vault ]; }
