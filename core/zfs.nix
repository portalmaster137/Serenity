# # ZFS Support NixOS module
{ config, lib, pkgs, ... }:

## Black magic wizardry from https://wiki.nixos.org/wiki/ZFS
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
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
  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  ## Enable zfs in kernel and boot
  boot = {
    ## Sets system to use the kernel specified in the let binding above
    kernelPackages = lib.mkForce latestKernelPackage;
    supportedFilesystems = [ "zfs" ];
    zfs = {
      ## uhhh
      #extraPools = [ "orcus" ];
      ## uhhh
      #forceImportRoot = false;
    };
  };
  networking = { hostId = "603b0c8b"; }; # Unsure why this is here actually ?

  ## Adding ZFS package to system just in case
  environment.systemPackages = with pkgs; [ zfs ];

  ## Enable trim for ZFS SSDs
  services = {
    zfs = {
      #trim.enable = true; # zfs trim service for SSDS
      autoScrub = { enable = true; }; # autoscrub data integrity ZFS service,
    };
  };

}
