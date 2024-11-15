{ inputs, outputs, lib, config, pkgs, ... }:

{

  imports = [
  ];

  nixpkgs = {
  };

  hardware.opentabletdriver = {
    enable = true;
     #package = [ ];
     #daemon.enable = true;
     #blacklistedKernelModules = [ ];
  };

  hardware.graphics.enable32Bit = true;

  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_BIN_HOME    = "$HOME/.local/bin";
    XDG_DATA_HOME   = "$HOME/.local/share";
    # Steam needs this to find Proton-GE
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    ## note: this doesn't replace PATH, it just adds this to it
    PATH = [ 
      "\${XDG_BIN_HOME}"
    ];
  };

  programs = {
    ## I wanted this in the user-level area
    steam = {
      enable = true;
      gamescopeSession = {
        enable = true;
      };
      package = pkgs.steam.override {
        extraLibraries = pkgs: [
          pkgs.xorg.libxcb
	];
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
      extraPackages = with pkgs; [
        gamescope
      ];
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    ## To run "normal" linux applications seamlessly
    appimage = {
      enable = true;
      binfmt = true;
    };

  };

  ## Enabling flatpak in case i need it
   #services.flatpak.enable = true;

  ## ratbagd for gaming mouse config
  services.ratbagd.enable = true;

  ## All common gaming packages declared here
  environment.systemPackages = with pkgs; [
     #steam # games storefront/launcher
    piper # mouse configuration
 ];

}
