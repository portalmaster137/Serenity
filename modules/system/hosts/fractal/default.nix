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
      inputs.double-minegrub-menu.inputs.minegrub-world-sel-theme.nixosModules.default
      inputs.minecraft-plymouth-theme.nixosModules.default
      double-minegrub-menu

      # selected features for this desktop
      terminal
      terminal-emulator
      desktop
      gaming
      cream-installer
      multimedia
    ];
  };

  flake.nixosModules.fractal-configuration =
    {
      config,
      lib,
      pkgs,
      user-parts,
      ...
    }:
    {
      networking.hostName = "fractal";
      # The partition currently on /dev/sdb; PARTUUID survives drive renumbering.
      fileSystems."/development" = {
        device = "/dev/disk/by-partuuid/803c7de5-8a56-4b1e-ba60-d88d886a2efc";
        fsType = "auto";
        options = [ "nofail" ];
      };

      networking.networkmanager = {
        enable = true;
        plugins = [ pkgs.networkmanager-openvpn ];
      };
      environment.systemPackages = [ pkgs.openvpn ];
      networking.firewall.allowedTCPPorts = [
        22
        80
        443
        8443
        5100
        25565
        3923
        7547
      ];
      networking.firewall.allowedUDPPorts = [
        25565
        5100
        443
        8443
        7547
      ];

      virtualisation.docker.enable = true;
      users.users.${user-parts.user.username}.extraGroups = [ "docker" ];
      boot = {
        loader = {
          grub = {
            enable = true;
            device = "nodev";
            efiSupport = true;
          };
          efi.canTouchEfiVariables = true;
          timeout = lib.mkDefault 5;
        };
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
