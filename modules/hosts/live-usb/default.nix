{ self, inputs, ... }:

{

  # defines the installer specific configuration
  flake.nixosConfigurations.usb = inputs.nixpkgs.lib.nixosSystem {

    # modules that comprise the installer specific configuration
    modules = with self.nixosModules; [

      # shared system modules
      core
      #user-options

      # host-specific options
      usb-configuration
      installer

      # extra modules to include on host
      terminal
      zfs-support
      network-proxy

      # users to include on host
      serenity

    ];

  };

  # host module declaration
  flake.nixosModules.usb-configuration =

    { pkgs, lib, ... }:

    {

      # set hostname
      networking.hostName = "serenityos";

      # bootloader settings
      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
          timeout = lib.mkDefault 5;
        };
        initrd.systemd.enable = true;
      };

      # supported filesystems at boot
      boot.supportedFilesystems = [
        "vfat"
        "ext4"
        "ntfs"
      ];

    };

}
