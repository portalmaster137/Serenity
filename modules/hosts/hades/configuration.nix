{ self, inputs, ... }:

{

  # host module declaration
  flake.nixosModules.hades-configuration =

    { pkgs, lib, ... }:

    {

      # other modules to import
      imports = [ ];

      # set hostname
      networking.hostName = "hades";

      # bootloader settings
      boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      # supported filesystems at boot
      boot.supportedFilesystems = [
        "vfat"
        "ext4"
        #"ntfs"
      ];

      # enable printing support
      services.printing.enable = true;

      # fstrim for ssd
      services.fstrim.enable = true;

      # corsair mouse software
      hardware.ckb-next.enable = true;

      # other packages for hades peripherals
      environment.systemPackages = with pkgs; [

        #input-remapper
        #razergenie
        #openrazer-daemon
        #openrgb-with-all-plugins

      ];

    };
}
