{ pkgs, ... }:

{
  imports = [

    ## Host-specific config files
    #./disko.nix
    ./network.nix
    ./hardware.nix
    ## Shared 'core' config options
    ../../../core
    ## Host-specific core modules
    ../../../core/modules/zfs.nix
    ../../../core/modules/gaming.nix
    ../../../core/modules/jellyfin.nix
    #../../../core/modules/bluetooth.nix

  ];

  ## ooh, hostname - this one's important!
  networking.hostName = "hades";

  ## ## ## ## ##

  boot = {

    kernelPackages = pkgs.linuxPackages_latest;

    supportedFilesystems = [ "vfat" "ext4" ];

    loader = {
      grub = {
        enable = true;
        device = "/dev/nvme0n1";
        enableCryptodisk = true;
      };
    };

    initrd.luks.devices = {
      root = { # Use https://nixos.wiki/wiki/Full_Disk_Encryption
        device = "/dev/disk/by-uuid/5526aab7-b779-4fc8-95bd-9452bc3a9232";
        preLVM = true;
      };

      #Asphodel = { # secondary partition on Tartarus drive
      #device = "/dev/disk/by-uuid/45f5f6ad-a676-4bc1-ad4b-e3e26b5697f4";
      #preLVM =false;
      #};
    };

  };

  ## ## ## ## ##

  hardware = {

    ## Bluetooth settings for Hades
    ## Also see line 94 for blueman service,
    ## and home/desktop/waybar.nix for tray applet.
    ## To do: Move bluetooth options to own module
    bluetooth = {
      enable = true;
      ## Turns the bluetooth adapter on at boot
      powerOnBoot = true;
      settings.General = {
        ## Displays battery charge of connected devices
        Experimental = true;
        ## Uses more power, but hades is a desktop
        FastConnectable = true;
      };
      ## To fix bluetooth keyboard input
      #input.General = { UserspaceHID = true; };
    };

    ## GPU and graphics
    graphics = {
      enable = true;
      enable32Bit = true;
      ## Packages for the iGPU inside Hades
      extraPackages = with pkgs;
        [
          #intel-compute-runtime
          #intel-media-driver
          #libvdpau-va-gl
          #vaapiIntel
          #vaapiVdpau
        ];
    };
    ## Driver packages for the dGPU inside Hades
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };
  };

  services = {
    ## Enables bluetooth service
    blueman.enable = true;
    ## Sets X to use amdgpu drivers
    xserver.videoDrivers = [ "amdgpu" ];
  };

  programs = {
    ## For tweaking system performance
    #corectrl = {
    #enable = true;
    ## Allows tweaking GPU performance
    #gpuOverclock = {
    #enable = true;
    ## Needed for radeon GPU overclocking
    #ppfeaturemask = "0xfffd7fff";
    #};
    #};
    ## Performance tweaking continued
    #tuxclocker = {
    #enable = true;
    #enableAMD = true;
    #useUnfree = true;
    #};
  };

  ## Some packages for managing the hardware inside Hades
  environment.systemPackages = with pkgs; [
    #umr
    lact
    radeontop
    #amdgpu_top
    #radeontools
    #radeon-profile
    nvtopPackages.amd
  ];

  ## Systemd services for lact
  systemd = {
    packages = with pkgs; [ lact ];
    services.lactd.wantedBy = [ "multi-user.target" ];
  };

}
