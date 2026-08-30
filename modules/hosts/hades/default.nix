{
  pkgs,
  lib,
  self,
  ...
}:
{

  # module paths to import
  imports = [
    ./hardware
    ./network
    ./radeon
  ];

  # select kernel to use
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;

  # set hostname
  networking.hostName = "hades";

  # for ssd
  services.fstrim.enable = true;

}
