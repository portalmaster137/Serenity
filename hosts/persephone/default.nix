{ lib, config, pkgs, ... }:

{
  imports = [

    ## Host specific files
    ./modules

    ## Shared 'core' config options
    ../../core/config.nix
  ];

  ## ooh, hostname - this one's important!
  networking.hostName = "persephone";

  hardware = {

    ## Enable bluetooth inside Persephone
    bluetooth.enable = true;

    ## Pick either "true" OR "lib.mkDefault -"
    cpu.intel.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;
    #cpu.intel.updateMicrocode = true;
    enableAllFirmware = true;
    graphics = {
      enable = true;
      ## Packages for integrated graphics inside Persephone
      extraPackages = with pkgs; [
        intel-compute-runtime
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  ## Trying out an alternate memory allocator
  #environment.memoryAllocator.provider = "graphene-hardened-light";

  ## Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  ## (the default) this is the recommended approach. When using systemd-networkd it's
  ## still possible to use this option, but it's recommended to use it in conjunction
  ## with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  #networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
  #networking.interfaces.wlp58s0.useDHCP = lib.mkDefault true;

  boot = {
    supportedFilesystems = [ "btrfs" "xfs" "ntfs" ];
    initrd = {
      systemd.enable = true;
      luks.devices = {
        "luks-6aecd578-c05b-425c-a86e-0a5153b896a1".device =
          "/dev/disk/by-uuid/6aecd578-c05b-425c-a86e-0a5153b896a1";
      };
    };
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi = {
        canTouchEfiVariables = true;
        #efiSysMountPoint = "/boot/efi";
      };
    };

  };

  ## Hardware-related services
  services = {
    ## TRIM to keep SSDs healthy-ish
    fstrim.enable = true;

  };

  powerManagement = {
    enable = true;
    powertop.enable = true;
    #cpuFreqGovernor = Lib.mkDefault "performance";
    #cpufreq = {
    #min = 1500000;
    #max = 4400000;
    #};
  };

  programs = {

    ## For tweaking system performance
    corectrl = { enable = true; };
    ## Performance tweaking continued
    tuxclocker = {
      enable = true;
      useUnfree = true;
    };

  };

  ## Some packages for managing the hardware inside Persephone
  environment.systemPackages = with pkgs; [ nvtopPackages.intel ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

}
