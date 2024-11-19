{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports = [
  ];

  services = {

    ## Eventual login greeter/display manager,
    ## wayland native.
    greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.greetd.regreet}/bin/regreet --cmd hyprland";
      };
    };

  };

  ## Eventual login greeter/display manager,
  ## wayland native.
  programs.regreet = {
    enable = true;
  };

}
