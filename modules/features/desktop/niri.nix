{ self, inputs, ... }: {

  # niri window manager module declaration
  flake.nixosModules.niri =
    { pkgs, lib, ... }:

    {

      imports = [
        # for home manager functionality
        inputs.home-manager.nixosModules.home-manager
        # for niri binary cache from epireyn
        # disable if untrusted
        inputs.niri.nixosModules.niri
      ];

      # for niri binary cache from epireyn
      # disable if untrusted
      niri-flake.cache.enable = true;

      # for latest niri versions
      nixpkgs.overlays = [ inputs.niri.overlays.niri ];

      # packages for desktop environment
      environment.systemPackages = with pkgs; [
        xwayland-satellite-unstable # niri xwayland support
      ];

      # session management
      programs.uwsm = {
        enable = true;
        # configures uwsm to launch niri
        waylandCompositors.niri = {
          prettyName = "Niri";
          comment = "Niri scrolling WM managed by UWSM";
          # points to niri binary and declares it as a session
          binPath = "/run/current-system/sw/bin/niri";
          extraArgs = [ "--session" ];
        };
      };

      # enables niri globally
      programs.niri = {
        enable = true;
        # use latest unstable version
        package = with pkgs; [ niri-unstable ];
        # xwayland implementation
        xwayland-satellite = {
          enable = true;
          path = lib.getExe pkgs.xwayland-satellite-unstable;
        };
      };

      # niri personalisation
      home-manager.users.serenity = {

        # for niri home manager module
        imports = [ inputs.niri.homeModules.niri ];

        programs.niri = {
          # enables niri within home manager
          enable = true;
          # uses latest unstable version
          package = with pkgs; [ niri-unstable ];
          # xwayland implementation
          xwayland-satellite = {
            enable = true;
            path = lib.getExe pkgs.xwayland-satellite-unstable;
          };

          # niri configuration
          #settings = { };

        };

      };

    };

}
