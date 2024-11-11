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
     #./regreet.nix
     #./sddm.nix
  ];

  services = {

    greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.greetd.regreet}/bin/regreet --cmd sway";
      };
    };

  };

  programs.regreet = {
    enable = true;
  };

}
