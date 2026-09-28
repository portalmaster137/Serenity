{ self, inputs, ... }:

{

  # defines the installer specific configuration
  flake.nixosConfigurations.installer = inputs.nixpkgs.lib.nixosSystem {

    # modules that comprise the host specific configuration
    modules = with self.nixosModules; [

      # shared system modules
      core
      #user-options

      # host-specific options
      installer-configuration

      # extra modules to include on host
      terminal
      zfs-support
      network-proxy

      # users to include on host
      serenity

    ];

  };

  # host module declaration
  flake.nixosModules.installer-configuration =

    {
      pkgs,
      lib,
      ...
    }:

    {

      # other modules to import
      imports = [ ];

      # set hostname
      networking.hostName = "serenityos";

      # bootloader settings
      boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      # supported filesystems at boot
      boot.supportedFilesystems = [
        "vfat"
        "ext4"
        "ntfs"
      ];

      # specifies x64 uArch
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    };

}
