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

     #config = {
       #blah.bleh = [ ];
     #};
     #extraConfig = {
     #};
    
     #extraSessionCommands = ''
     #'';
  };

  home.packages = with pkgs; [

  ];

}
