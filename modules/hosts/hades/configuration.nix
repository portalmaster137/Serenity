{ self, inputs, ... }: {

  flake.nixosModules.hadesConfiguration = { pkgs, lib, ... }: {
    # import any other modules from here
    imports = [
      self.nixosModules.hadesHardware
      self.nixosModules.niri
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Packages
    environment.systemPackages = with pkgs; [
      # peripherals & Input
      input-remapper # Input control
      razergenie # Razer frontend
      openrazer-daemon # Razer daemon
      openrgb-with-all-plugins # RGB control
    ];
  };

}
