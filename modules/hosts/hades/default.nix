{ self, inputs, ... }:

{

  # defines the hades specific configuration
  flake.nixosConfigurations.hades =
    inputs.nixpkgs.lib.nixosSystem

      {

        # modules that comprise the host specific configuration
        modules = with self.nixosModules; [

          # user modules
          serenity # user module declaration

          # shared system modules
          core # shared configuration options
          user-parts # user variables

          # host-specific modules
          hades-configuration # host specific configuration options below
          hades-hardware # hardware configuration options for host
          zfs-support # zfs support module for hades specific zpool

          # feature modules
          virtualisation # virtual machines
          network-proxy # basic dns crypt proxy
          kde-connect # phone <-> desktop connectivity
          terminal # most terminal programs
          terminal-emulator # terminal program for desktops
          desktop # most desktop programs
          music # music consumption
          music-production # music creation
          gaming # gaming modules, steam, osu, etc.
          multimedia # image and video programs
          virtual-reality # configuration for vr setup

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

      # cpu settings
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      # gpu monitoring and control
      services.lact = {
        enable = true;
      };

      # gpu firmware - https://nixos.wiki/wiki/AMD_GPU
      boot = {
        # gpu drivers during boot and pre boot
        initrd.kernelModules = [ "amdgpu" ];
        # exposes gpu drivers to system
        kernelModules = [
          "amdgpu"
          "kvm-amd"
        ];
      };
      hardware = {
        # amd discrete graphics support
        graphics.enable = true;
        amdgpu = {
          # fixes early video issues
          initrd.enable = true;
          # amd sanctioned overclocking
          overdrive = {
            enable = true;
            #ppfeaturemask = "0xfffd7fff"; # default
            ppfeaturemask = "0xffffffff"; # all overdrive features
          };
        };
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
