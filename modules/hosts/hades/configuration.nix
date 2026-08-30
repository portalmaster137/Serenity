{ self, ... }:

{

  # defines a module
  flake.nixosModules.hadesConfig =
    {
      pkgs,
      lib,
      self,
      ...
    }:

    {

      # other modules to import
      imports = [
        self.nixosModules.hadesHardware
        self.nixosModules.coreConfig
        self.nixosModules.programs
        self.nixosModules.niri
      ];

      # set hostname
      networking.hostName = "hades";

      # specify kernel to use
      boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;

      # enable printing support
      services.printing.enable = true;

      # fstrim for ssd
      services.fstrim.enable = true;

      # nixify this more betterer
      users.users.serenity = {
        shell = pkgs.fish;
        ignoreShellProgramCheck = true;
        isNormalUser = true;
        description = "";
        extraGroups = [
          "networkmanager"
          "wheel"
          "i2c"
          "audio"
          "video"
          "input"
        ];

        # user specific packages
        packages = with pkgs; [
          tree
        ];
      };

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
        openrgb-with-all-plugins
      ];

      # dont touch this
      system.stateVersion = "24.11";

    };
}
