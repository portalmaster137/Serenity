{ pkgs, ... }:

{

  imports = [
    ./web.nix
    ./obs.nix
    ./music.nix
  ];

  ## Easy effects daemon
  services.easyeffects.enable = true;

  home.packages = with pkgs; [

    # Browsing & Filesharing
    transmission_4-gtk # Torrent client
    nicotine-plus # P2P Media sharing
    carburetor # GUI settings for tractor
    syncplay # Synchronise media playback
    #lagrange # GUI Gemini browser
    tractor # TOR network routing
    tor # The Onion Router

    # Messaging & Social
    #telegram-desktop
    #fractal-next
    #fractal
    vesktop

    # Image
    gimp # General image editing
    #inkscape # Vector image editing

    # Video
    vlc # Video playback
    #shotcut # Video editing

    # 3D Creative
    blender # 3D modelling software
    orca-slicer # 3D print slicing

    # Miscellaneous
    themix-gui # for creating gtk themes
    obsidian # note taking
  ];

  programs = {

    # Web browser
    firefox = { enable = true; };

    # Note taking
    obsidian = {
      enable = true;
    };

    # Screenshare & recording
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        #droidcam-obs
      ];
    };
  };

}
