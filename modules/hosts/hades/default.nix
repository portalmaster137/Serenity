{
  pkgs,
  lib,
  self,
  ...
}:
{
  imports = [
    ./hardware
    ./network 
    ./radeon
  ];

  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;

  networking.hostName = "hades";

  security.tpm2.enable = true;

  # for SSD/NVME
  services.fstrim.enable = true;

}
