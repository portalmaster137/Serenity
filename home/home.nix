{ ... }:

{

  imports = [
    ./programs
    ./programs/optional/obs
    ./programs/optional/chat
    ./programs/optional/beets.nix
    ./programs/optional/multimedia.nix
  ];
  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

}
