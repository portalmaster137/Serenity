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

    greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.greetd.regreet}/bin/regreet --cmd hyprland";
      };
    };

  };

  programs.regreet = {
    enable = true;
  };

}
