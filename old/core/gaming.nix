{ pkgs, inputs, user, ... }:

{

  environment = {

    # These are important apparently :uh:
    sessionVariables = {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_BIN_HOME = "$HOME/.local/bin";
      XDG_DATA_HOME = "$HOME/.local/share";
      # Steam needs this to find Proton-GE
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
      # Note: this doesn't replace PATH, it just adds this to it
      PATH = [ "\${XDG_BIN_HOME}" ];
      NIXOS_OZONE_WL = "1";
      SDL_VIDEODRIVER = "x11,wayland,windows";
    };

    # Games and misc.
    systemPackages = with pkgs; [
      piper # Open mouse config 
      vassal # FOSSy board game sim
      cockatrice # Magical the gathering, but free
      prismlauncher # Modded Minecraft client
      osu-lazer-bin # Rhythm is just a click away!
      inputs.nix-gaming.packages.${pkgs.system}.osu-mime
      #inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
    ];
  };

  # Adding primary user to gamemode group
  users.users.${user}.extraGroups = [ "gamemode" ];
  # Gaming mouse config
  services.ratbagd.enable = true;
  # Enable 32bit graphics support
  hardware.graphics.enable32Bit = true;
  # Open tablet driver, for Osu!, mainly.
  hardware.opentabletdriver = {
    enable = true; # Enables the driver lol
    daemon.enable = true; # Enables the daemon via systemd
    blacklistedKernelModules = [ # Disable conflicting drivers
      "hid-uclogic"
      "wacom"
    ];
  };

  programs = {

    java.enable = true; # just in case
    gamescope = {
      enable = true; # compositor for games
      capSysNice = true; # should make games run better
    };

    # Steam
    steam = {
      enable = true; # enables steam itself
      protontricks.enable = true; # enables protontricks
      gamescopeSession.enable = true; # compositor for games
      extraCompatPackages = with pkgs; [ proton-ge-bin ]; # glorious eggroll
      package = pkgs.steam.override { # no clue lol
        extraLibraries = pkgs: [ pkgs.libxcb ]; # what
        extraPkgs = pkgs: with pkgs; [ # absolutely clueless lol
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
          gamemode
          libxi 
          libxcursor 
          libxinerama 
          libxscrnsaver 
        ];
      };
    };

    # "GameMode" - https://nixos.wiki/wiki/Gamemode
    gamemode = {
      enable = false;
      settings = {
        general.renice = 10;
        # Warning: GPU optimisations have the potential to damage hardware
        gpu = {
          apply_gpu_optimisations = "accept-responsibility";
          gpu_device = 0;
          amd_performance_level = "high";
        };
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
        };
      };
    };

  };

}
