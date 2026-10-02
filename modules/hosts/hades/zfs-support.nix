{ self, inputs, ... }:

{

  flake.nixosModules.zfs-support =

    {
      config,
      lib,
      pkgs,
      ...
    }:

    let

      # matches kernel to latest with zfs support
      # Black magic wizardry from https://wiki.nixos.org/wiki/ZFS
      zfsCompatibleKernelPackages = lib.filterAttrs (
        name: kernelPackages:
        (builtins.match "linux_[0-9]+_[0-9]+" name) != null
        && (builtins.tryEval kernelPackages).success
        && (!kernelPackages.${config.boot.zfs.package.kernelModuleAttribute}.meta.broken)
      ) pkgs.linuxKernel.packages;
      latestKernelPackage = lib.last (
        lib.sort (a: b: (lib.versionOlder a.kernel.version b.kernel.version)) (
          builtins.attrValues zfsCompatibleKernelPackages
        )
      );

    in

    {
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      boot = {
        # sets system to use latest zfs compatible kernel
        kernelPackages = lib.mkForce latestKernelPackage;
        # adds zfs support at boot
        supportedFilesystems = [ "zfs" ];
        # zfs boot settings
        boot.zfs = {
          forceImportRoot = false;
          # imports hades specific zpool
          extraPools = [ "orcus" ];
        };
      };

      # adds zfs to system packages
      environment.systemPackages = with pkgs; [ zfs ];

      # is this needed? - YES nixos yelled at me about it
      networking.hostId = "603b0c8b";

      # data integrity service
      services.zfs.autoScrub.enable = true;
    };

}
