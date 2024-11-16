{ self, inputs, outputs, lib, config, pkgs, ... }:

{

  services = {
    udiskie = {
      enable = true;
      tray = "always";
      automount = true;
      notify = true;
       #settings = {
       #};
    };
  };

}
