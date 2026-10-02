{ self, inputs, ... }:

{

  # defines the installer specific configuration
  flake.nixosConfigurations.usb = inputs.nixpkgs.lib.nixosSystem {

    # modules that comprise the installer specific configuration
    modules = with self.nixosModules; [

      # shared system modules
      core

      # host-specific options
      usb-configuration

      # extra modules to include on host
      terminal
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

      # extra supported filesystems at boot
      boot.supportedFilesystems = [
        "ntfs"
      ];

    };

}
