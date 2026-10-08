{ self, inputs, ... }:

{
  # defines the template specific configuration
  # copy this directory and rename for new hosts
  flake.nixosConfigurations.template =
    inputs.nixpkgs.lib.nixosSystem
    {
      modules = with self.nixosModules; [
        # user modules
        serenity # user module declaration

        # shared system modules
        core # shared configuration options
        user-parts # user variables

        # host-specific modules
        template-configuration # host specific configuration options below

        # feature modules
        terminal # most terminal programs
        network-proxy # basic dns crypt proxy

        # desktop features (uncomment as needed)
        # desktop # most desktop programs
        # terminal-emulator # terminal program for desktops
        # gaming # gaming modules, steam, osu, etc.
        # media-server # remote mediashare configuration
        # music # music consumption
        # music-production # music creation
        # multimedia # image and video programs
        # virtual-reality # configuration for vr setup
        # kde-connect # phone <-> desktop connectivity
      ];
    };

  # host module declaration
  flake.nixosModules.template-configuration =
    { pkgs, lib, ... }:
    {
      # set hostname
      networking.hostName = "template";

      # bootloader settings
      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
          timeout = lib.mkDefault 5;
        };
        initrd.systemd.enable = true;
      };

      # CPU microcode (uncomment for your CPU vendor)
      # hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      # hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      # fstrim for ssd
      services.fstrim.enable = true;

      # GPU support (uncomment as needed)
      # hardware.graphics.enable = true;
      # hardware.graphics.enable32Bit = true;

      # NVIDIA GPU (uncomment if needed)
      # services.xserver.videoDrivers = [ "nvidia" ];
      # hardware.nvidia = {
      #   modesetting.enable = true;
      #   open = true;
      #   nvidiaSettings = true;
      #   package = config.boot.kernelPackages.nvidiaPackages.stable;
      # };
      # boot.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

      # AMD GPU (uncomment if needed)
      # hardware.amdgpu = {
      #   initrd.enable = true;
      #   overdrive = {
      #     enable = true;
      #     ppfeaturemask = "0xffffffff";
      #   };
      # };
      # boot = {
      #   initrd.kernelModules = [ "amdgpu" ];
      #   kernelModules = [ "amdgpu" "kvm-amd" ];
      # };

      # Bluetooth (uncomment if needed)
      # hardware.bluetooth = {
      #   enable = true;
      #   powerOnBoot = true;
      # };

      # Printing support (uncomment if needed)
      # services.printing.enable = true;

      # Add host-specific packages here
      environment.systemPackages = with pkgs; [
        # Add host-specific packages
      ];
    };
}
