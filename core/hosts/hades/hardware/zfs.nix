## ZFS Support NixOS module

## temporary location while we figure out how ZFS works,
## eventually this will be embedded into the flake in a better way

{ config, lib, pkgs, ... }:

let
  ## This 'let' binding creates an attribute set
  ## called "LatestZfsLinux", which we can call as
  ## a package to specify when building our kernel.
  latestZfsLinux = lib.pipe pkgs.linuxKernel.packages [
    builtins.attrValues
    (builtins.filter (
      kPkgs:
      (builtins.tryEval kPkgs).success
      && kPkgs ? kernel
      && kPkgs.kernel.pname == "linux"
      && !kPkgs.zfs.meta.broken
    ))
    (builtins.sort (a: b: (lib.versionOlder a.kernel.version b.kernel.version)))
    lib.last
  ];
in

{

  imports = [ 
  ];

  ## Enable zfs in kernel and boot
  boot = {
    kernelPackages = latestZfsLinux;
    supportedFilesystems = [ "zfs" ];
    zfs = {
       #extraPools = [ "diska" "diskb" ];
      forceImportRoot = false;
    };
  };

  environment.systemPackages = with pkgs; [
    zfs
  ];

  ## Enable trim for ZFS SSDs
  services = {
    zfs = {
      ## Trim for SSSds with ZFS
      trim.enable = true;
      ## Autoscrub data integrity ZFS service,
      ## more to be added soon
      autoScrub = {
        enable = true;
      };
    };
  };

}
