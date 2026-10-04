{ self, inputs, ... }:

{

  # defines the installer specific configuration
  # use the following command to build a bootable iso
  # with the declared system configuration
  # `$ nix run nixpkgs#nixos-generators -- --format iso --flake .#usb -o result`
  flake.nixosConfigurations.usb = inputs.nixpkgs.lib.nixosSystem {

    # modules that comprise the installer specific configuration
    modules = with self.nixosModules; [

      # user modules
      serenity # user module declaration

      # shared system modules
      core # shared core system modules
      user-parts # basic user library

      # host-specific modules
      usb-configuration # defined below

      # feature modules
      terminal # full featured terminal supermodule
      network-proxy # basic dnscrypt proxy

    ];

  };

  # host module declaration
  flake.nixosModules.usb-configuration =

    { pkgs, lib, ... }:

    {

      # set hostname
      networking.hostName = "serenity-os";

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
