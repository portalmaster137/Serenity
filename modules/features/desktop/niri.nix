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
        # conflicts with unstable overlay
        #inputs.niri.nixosModules.niri
      ];

      # for niri binary cache from epireyn
      # disable if untrusted
      #niri-flake.cache.enable = true;

      # for latest niri versions - disable if using binary cache
      nixpkgs.overlays = [ inputs.niri.overlays.niri ];

      # packages for desktop environment
      environment.systemPackages = with pkgs; [
        xwayland-satellite # niri xwayland support - disable if using unstable
        #xwayland-satellite-unstable # niri xwayland support - disable if using stable
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
        # use latest nixpkgs version - disable if using binary cache or unstable
        package = with pkgs; niri;
        # use latest unstable version - disable if using binary cache or stable
        #package = with pkgs; niri-unstable;
      };

      # niri personalisation
      home-manager.users.serenity = {

        # for niri home manager module
        imports = [ inputs.niri.homeModules.niri ];

        programs.niri = {
          # enables niri within home manager
          enable = true;
          # use latest nixpkgs version - disable if using binary cache or unstable
          package = with pkgs; niri;
          # uses latest unstable version - disable if using binary cache or stable
          #package = with pkgs; niri-unstable;
          settings = {

            # xwayland implementation
            xwayland-satellite = {
              enable = true;
              # use niri-stable matching version - disable if using unstable
              path = lib.getExe pkgs.xwayland-satellite;
              # use niri-unstable matching version - disable if using stable
              #path = lib.getExe pkgs.xwayland-satellite-unstable;
            };

            # display configuration
            #foo.bar = { };

          };

        };

      };

    };

}
