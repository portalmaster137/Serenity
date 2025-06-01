{ ... }:

{

  imports = [

    ./desktop # desktop
    ./scripts # scripts
    ./programs # other programs

  ];

  programs.home-manager.enable = true; # enables HM
  systemd.user.startServices = "sd-switch"; # cant remember

}
