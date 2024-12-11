{
  self,
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

  imports = [
    #./sway-style.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;
    checkConfig = false;
    package = pkgs.swayfx;
    wrapperFeatures = {
      base = true;
      gtk = true;
    };
    systemd = {
      enable = true;
       #xdgAutostart = true;
       #extraCommands = [
       #];
       #variables = [
       #];
    };

    config = rec {
      modifier = "Mod4";
      ## Use Wofi as menu
      menu = "wofi";
      ## Use kitty as default terminal
      terminal = "kitty";
      startup = [
        {command = "startup";}
        {command = "kitty";}
      ];

      focus = {
        followMouse = true;
	      mouseWarping = false;
        newWindow = "smart";
      };

    };

     #extraConfig = {
     #};
    
     #extraSessionCommands = ''
     #'';
  };

  home.packages = with pkgs; [

  ];

}
