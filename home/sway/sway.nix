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

  ];

  wayland.windowManager.sway = {

    checkConfig = false;

    xwayland = true;
    enable = true;
    package = pkgs.swayfx-unwrapped;
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
      ## Use kitty as default terminal
      terminal = "kitty";
      startup = [
        {command = "firefox";}
        {command = "kitty";}


      ];
    };
     #extraConfig = {
     #};
    
     #extraSessionCommands = ''
     #'';
  };

  home.packages = with pkgs; [

  ];

}
