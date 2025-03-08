{ ... }:

{

  imports =
    [ ./programs ./programs/obs ./programs/chat ./programs/multimedia.nix ];

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

}
