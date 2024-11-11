{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
  ];

  services = {
    ## login greeter/display manager,
    ## set to run wayland.
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

  };

}
