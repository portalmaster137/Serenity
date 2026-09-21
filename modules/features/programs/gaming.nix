{ inputs, ... }: {

  # general gaming module declaration
  flake.nixosModules.gaming =
    {
      inputs,
      pkgs,
      user,
      ...
    }:
    {

      # 32bit graphics support
      hardware.graphics.enable32Bit = true;

      # session variables
      environment.sessionVariables = {

        # xdg data directories
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_CACHE_HOME = "$HOME/.cache";
        XDG_DATA_HOME = "$HOME/.local/share";
        XDG_BIN_HOME = "$HOME/.local/bin";
        # adds bin directory to path
        path = [ "\${XDG_BIN_HOME}" ];

        # needed for steam to find proton versions
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";

        # display variables
        SDL_VIDEODRIVER = "x11,wayland,windows";
        NIXOS_OZONE_WL = "1";

      };

      # for gamemode functionality
      users.users = {
        serenity.extraGroups = [ "gamemode" ];
      };

      # gaming performance - need to research
      # https://wiki.nixos/wiki/Gamemode
      #gamemode = {
      #enable = true;
      #settings = { };
      #};

      # steam
      programs.steam = {
        enable = true;
        # gaming compositor - disabled for now
        gamescopeSession.enable = false;
        # enables proton
        protontricks.enable = true;
        extraCompatPackages = with pkgs; [ proton-ge-bin ];
      };

      # tablet driver for osu
      hardware.opentabletdriver = {
        enable = true;
        # enables systemd daemon
        daemon.enable = true;
        # disable conflicting drivers
        blacklistedKernelModules = [
          "hid-uclogic"
          "wacom"
        ];
      };

      # other packages to include
      environment.systemPackages = with pkgs; [
        cockatrice # mtg client
        prismlauncher # modded minecraft
        osu-lazer-bin # rhythm is just a click away!
        #inputs.nix-gaming.packages.${pkgs.system}.osu-mime # osu mime types
      ];

    };

  # virtual reality module declaration
  # README - https://wiki.nixos.org/wiki/VR
  flake.nixosModules.virtual-reality =
    { pkgs, user, ... }:

    {

      # for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # physical input
      users.users = {
        serenity.extraGroups = [ "input" ];
      };

      # hand tracking
      home-manager.users = {
        serenity = {
          # avoids downloading large files directly
          programs.git.lfs.enable = true;
          # copies lfs pointers for tracking models into config dir
          # disabled for now
          #home.file = ".local/share/monado/hand-tracking-models".source = pkgs.fetchgit {
          #url = "https://gitlab.freedesktop.org/monado/utilities/hand-tracking-models";
          #sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
          #fetchLFS = true;
          #};
        };
      };

      # extra packages for vr
      environment.systemPackages = with pkgs; [
        sidequest
        wayvr
      ];

      # monado runtime
      # commands to run and log monado
      # TODO: nixify this?
      # `$ systemctl --user start monado.service`
      # `$ jounralctl --user --follow --unit monado.service`
      services.monado = {
        enable = true;
        # use as default openxr runtime
        defaultRuntime = true;
        # sets as high priority service in kernel
        # may fix some performance issues
        highPriority = true;
      };

      # environment variables for monado runtime
      systemd.user.services.mondado.environment = {
        STEAMVR_LH_ENABLE = "1";
        XRT_COMPOSITOR_COMPUTE = "1";
        # disables hand tracking, re-enable after downloading models
        #WMR_HANDTRACKING = "0";
      };

      # amdgpu patch, may fix some performance issues
      # required for monado high priority scheduling
      # requires kernel recompile, disable if undesired
      # OR patch only amdgpu itself
      # https://wiki.nixos.org/wiki/Linux_kernel#Patching_a_single_In-tree_kernel_module
      boot.kernelPatches = [
        {
          name = "amdgpu-ignore-ctx-privileges";
          patch = pkgs.fetchpatch {
            name = "cap_sys_nice_begone.patch";
            url = "https://github.com/Frogging-Family/community-patches/raw/master/linux61-tkg/cap_sys_nice_begone.mypatch";
            hash = "sha256-Y3a0+x2xvHsfLax/uwycdJf3xLxvVfkfDVqjkxNaYEo=";
          };
        }
      ];

      # wivrn service
      services.wivrn = {
        enable = true;
        # wireless connectivity
        openFirewall = true;
        # run at startup via systemd
        autoStart = true;
        # steam integration
        steam.enable = true;
      };

      # wivrn firewall ports
      networking.firewall = {
        allowedTCPPorts = [ 9757 ];
        allowedUDPPorts = [
          9757
          5353
        ];
      };

      # wayvr virtual desktop
      systemd.user.services.wayvr = {
        description = "WayVR desktop overlay for OpenXR/OpenVR";
        # assigns it as a graphical service
        partOf = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        wantedBy = [ "graphical-session.target" ];
        serviceConfig = {
          # points to executable to use for wayvr
          ExecStart = "${pkgs.wayvr}/bin/wayvr --replace";
          # restarts wayvr if it crashes
          Restart = "on-failure";
        };
      };

    };

}
