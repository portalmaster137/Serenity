{ self, inputs, ... }:

{

  # defines the hades specific configuration
  flake.nixosConfigurations.hades =
    inputs.nixpkgs.lib.nixosSystem

      {

        # modules that comprise the host specific configuration
        modules = with self.nixosModules; [

          # shared system modules
          core
          #user-options

          # host-specific modules
          hades-configuration
          hades-hardware
          zfs-hades

          # feature modules
          virtualisation
          network-proxy
          zfs-support
          terminal
          desktop
          music
          gaming
          multimedia
          virtual-reality
          music-production

          # user modules
          serenity

        ];

      };

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
