{ self, inputs, ... }:

{

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

      # for desktop-less flatpak in installer
      xdg.portal.enable = true;

      # specifies x64 uArch
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    };

}
