{ self, inputs, ... }:

{

  # host module declaration
  flake.nixosModules.hades =

    { pkgs, lib, ... }:

    {

      # other modules to import
      imports = [ ];

      # set hostname
      networking.hostName = "hades";

      # specify kernel to use
      boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;

      # enable printing support
      services.printing.enable = true;

      # fstrim for ssd
      services.fstrim.enable = true;

      # enable firefox
      programs.firefox.enable = true;

      # other packages to include
      environment.systemPackages = with pkgs; [

        # tools and utilities
        git
        helix

        # packages for hades peripherals
        input-remapper
        razergenie
        openrazer-daemon
        openrgb-with-all-pluginsi

      ];

      # amd radeon gpu drivers and software
      # https://nixos.wiki/wiki/AMD_GPU
      boot = {
        # load amdgpu driver pre boot
        initrd.kernelModules = [ "amdgpu" ];
        #exposes gpu driver
        kernelModules = [
          "amdgpu"
          "kvm-amd"
        ];
      };
      hardware = {
        # discrete graphics support
        graphics.enable = true;
        # fixes early video issues
        amdgpu.initrd.enable = true;
      };

    };
}
