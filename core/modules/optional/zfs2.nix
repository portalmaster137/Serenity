# # ZFS Support NixOS module

## temporary location while we figure out how ZFS works,
## eventually this will be embedded into the flake in a better way

{ config, lib, pkgs, ... }:

## Black magic wizardry from https://wiki.nixos.org/wiki/ZFS
let

  zfsCompatibleKernelPackages = lib.filterAttrs (name: kernelPackages:
    (builtins.match "linux_[0-9]+_[0-9]+" name) != null
    && (builtins.tryEval kernelPackages).success
    && (!kernelPackages.${config.boot.zfs.package.kernelModuleAttribute}.meta.broken))
    pkgs.linuxKernel.packages;
  latestKernelPackage = lib.last
    (lib.sort (a: b: (lib.versionOlder a.kernel.version b.kernel.version))
      (builtins.attrValues zfsCompatibleKernelPackages));

in {

  imports = [ ];

  ## Enable zfs in kernel and boot
  boot = {
    ## Sets system to use the kernel specified in the let binding above
    kernelPackages = lib.mkForce latestKernelPackage;
    supportedFilesystems = [ "zfs" ];
    zfs = {
      ## uhhh
      extraPools = [ "orcus" ];
      ## uhhh
      forceImportRoot = false;
    };
  };

  #fileSystems."/run/media/serenity/Orcus" = {
  #device = "orcus";
  #fsType = "zfs";
  #options = [ "users" ];
  #};

  ## Adding ZFS package to system just in case
  environment.systemPackages = with pkgs; [ zfs ];

  ## Enable trim for ZFS SSDs
  services = {
    zfs = {
      ## Trim for SSSds with ZFS
      #trim.enable = true;
      ## Autoscrub data integrity ZFS service,
      ## more to be added soon
      autoScrub = { enable = true; };
    };
  };

  ## Automount service for the ZFS pools
  ## Is supposed to be enabled by default
  #systemd.services.zfs-mount = {
  #enable = true;
  #};

  ## Unsure why this is here actually ?
  networking = { hostId = "603b0c8b"; };

}
