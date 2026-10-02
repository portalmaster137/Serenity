{ self, inputs, ... }:

{

  # defines the hades specific configuration
  flake.nixosConfigurations.hades =
    inputs.nixpkgs.lib.nixosSystem

      {

        # modules that comprise the host specific configuration
        modules = with self.nixosModules; [

          # shared system modules
          core # shared configuration options
          user-parts # user variables

          # host-specific modules
          hades-configuration # host specific configuration options below
          hades-hardware # hardware configuration options for host
          zfs-hades # specific zfs configuration for host

          # feature modules
          virtualisation
          network-proxy
          zfs-support
          kde-connect
          terminal
          terminal-emulator
          desktop
          music
          music-production
          gaming
          multimedia
          virtual-reality

          # user modules
          serenity

        ];

      };

  # host module declaration
  flake.nixosModules.hades-configuration =

    { pkgs, lib, ... }:

    {

      # set hostname
      networking.hostName = "hades";

      # bootloader settings
      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
          timeout = lib.mkDefault 5;
        };
        initrd.systemd.enable = true;
      };

      # gpu monitoring and control
      services.lact = {
        enable = true;
      };
      hardware.amdgpu = {
        overdrive.enable = true;
      };

      # fstrim for ssd
      services.fstrim.enable = true;

      # corsair mouse software
      hardware.ckb-next.enable = true;

      # enable printing support
      services.printing.enable = true;

      # other packages for hades hardware and peripherals
      environment.systemPackages = with pkgs; [

        # hades performance and hardware
        s-tui # stress testing
        undervolt # cpu tweaking

        # hades peripherals
        #input-remapper # razer keypad
        #razergenie # razer keypad
        #openrazer-daemon # razer keypad
        #openrgb-with-all-plugins # for various rgb devices
        android-cli # adb for vr headset
        android-tools # adb for vr headset

      ];

    };

}
