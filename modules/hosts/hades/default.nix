{ pkgs, lib, self, ... }: {

  imports = [
    ./hardware
    ./network 
    ./radeon
  ];

  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;

  # Set hostname
  networking.hostName = "hades";

  # For SSD/NVME
  services.fstrim.enable = true;

}
