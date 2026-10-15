{ self, inputs, ... }:

{

  flake.nixosConfigurations.fractal = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      # user and shared system modules
      serenity
      core
      user-parts

      # machine hardware and settings
      fractal-configuration
      fractal-hardware

      # selected features for this desktop
      network-proxy
      terminal
      terminal-emulator
      desktop
      gaming
      multimedia
    ];
  };

  flake.nixosModules.fractal-configuration =
    {
      config,
      lib,
      user-parts,
      ...
    }:
    {
      networking.hostName = "fractal";
      networking.networkmanager.enable = true;

      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
          timeout = lib.mkDefault 5;
        };
        initrd.systemd.enable = true;
      };

      hardware.enableRedistributableFirmware = true;
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      # RTX 5060 Ti (Blackwell) uses NVIDIA's open kernel modules.
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        modesetting.enable = true;
        open = true;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };

      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
      };

      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        pulse.enable = true;
        wireplumber.enable = true;
      };

      services.fstrim.enable = true;


      nixpkgs.config = { allowBroken = true; allowUnfree = true; };
      # Display arrangement detected on fractal: HDMI-A-1 is primary,
      # with DP-2 immediately to its right.
      home-manager.users.${user-parts.user.username} = {
        programs.niri.settings = {
          outputs = lib.mkForce {
            "HDMI-A-1" = {
              focus-at-startup = true;
              mode = {
                width = 1920;
                height = 1080;
                refresh = 179.998;
              };
              position = {
                x = 0;
                y = 0;
              };
            };
            "DP-2" = {
              mode = {
                width = 1920;
                height = 1080;
                refresh = 59.96;
              };
              position = {
                x = 1920;
                y = 0;
              };
            };
          };
          workspaces."01sys".open-on-output = lib.mkForce "HDMI-A-1";
        };

        programs.noctalia.settings.bar.monitors = lib.mkForce [
          "HDMI-A-1"
          "DP-2"
        ];
      };
    };

  flake.nixosModules.fractal-hardware =
    { ... }:
    {
      # This tracked root-level file is populated by nixos-generate-config.
      imports = [ ../../../../hardware-configuration.nix ];
      boot.supportedFilesystems = [ "btrfs" ];
    };

}
