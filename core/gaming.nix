{ pkgs, ... }:

{

  imports = [
  ];

  nixpkgs = {
  };

  hardware = {

    opentabletdriver = {
      ## Open tablet driver, for Osu!, mainly.
      enable = true;
      ## Disable conflicting drivers
      blacklistedKernelModules = [
        "hid-uclogic"
        "wacom"
      ];
      ## Enables the daemon via systemd
      daemon.enable = true;
    };

  };

  services = {
    ## Enabling flatpak in case i need it
     #flatpak.enable = true;
    ## ratbagd for gaming mouse config
    ratbagd.enable = true;
  };

  environment = {
    ## All common gaming packages declared here
    systemPackages = with pkgs; [
       #steam # games storefront/launcher
      piper # mouse configuration
    ];
    ## These are important apparently :uh:
    sessionVariables = {
      XDG_CACHE_HOME  = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_BIN_HOME    = "$HOME/.local/bin";
      XDG_DATA_HOME   = "$HOME/.local/share";
      ## Steam needs this to find Proton-GE
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
      ## Note: this doesn't replace PATH, it just adds this to it
      PATH = [ "\${XDG_BIN_HOME}" ];
    };
  };

  programs = {
    ## Java for some reason
    java.enable = true;

    ## To run "normal" linux applications seamlessly
    appimage = {
      enable = true;
      binfmt = true;
    };

    ## Gamescope compositor for steam
    ## (config copy-pasted from nixos wiki)
    gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "--rt"
	"--expose-wayland"
      ];
    };

    ## "GameMode" - https://nixos.wiki/wiki/Gamemode
    ## (config copy-pasted from mynixos)
    gamemode = {
      enable = true;
      settings = {
        general = {
          renice = 10;
        };
        ## Warning: GPU optimisations have the potential to damage hardware
        gpu = {
          apply_gpu_optimisations = "accept-responsibility";
          gpu_device = 0;
          amd_performance_level = "high";
        };
        custom = {
           #start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
           #end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
        };
      };
    };

    ## Steam itself
    steam = {
      enable = true;
      ## This should help games run more betterer
      gamescopeSession = {
        enable = true;
      };
      ## No clue what this is doing
      package = pkgs.steam.override {
        extraLibraries = pkgs: [
          pkgs.xorg.libxcb
	];
	## No clue what this shit does
	extraPkgs = pkgs: with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
          gamemode
	];
      };
      ## Not sure we need gamescope here
      ## as it's defined elsewhere but o well
      extraPackages = with pkgs; [
        gamescope
      ];
      ## Gotta have the glorious eggroll
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

  };

}
