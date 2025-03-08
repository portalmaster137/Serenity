{ ... }:

{

  imports = [

    ## Desktop
    ./desktop
    ../scripts

    ## Programs
    ./programs

  ];

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

}
