{ pkgs, ... }:

{

  imports = [

    ## Import program configs
    ./firefox
    ./nheko
    ./fetch
    ./kitty
    ./btop
    ./yazi
    ./nvim
    ./fish
    ./obs
    ./git

  ];

  home.packages = with pkgs; [

    ## Games
    osu-lazer-bin # Rhythm is just a click away!
    cockatrice # Magical the gathering but free
    vassal # fossy board-game sim :3

    ## Chat & Web
    lagrange # Browser for the gemini protocol
    vesktop # Modded discord wrapper
    fractal # GTK matrix client - need to fix gnome-keyring
    tor # The Onion Router

    ## Media
    #lollypop # GTK music player
    spotify # Corpo music streaming
    #pragha # Music player
    #tauon # Music player
    transmission_4-gtk # Torrent client
    nicotine-plus # P2P Media sharing
    #jellyfin # Self-Hosted media streaming
    syncplay # Synchronise local playback with friends
    vlc # Multimedia player

    ## Productivity
    #thunderbird # Email client - commented out due to network issues trying to build it ?
    obsidian # Note-taking

    ## Audio playback and production
    neural-amp-modeler-lv2 # Guitar amp emulator
    bespokesynth # Modular synthesiser and sequencer
    easyeffects # EQ and audio effects
    metronome # A metronome
    vcv-rack # Analogue-Synth emulator
    #cardinal # VCV Rack but open source and as a plugin
    audacity # Audio editing
    reaper # DAW
    helvum # GTK patchbay
    ardour # Digital Audio Workstation
    vital # synth
    helm # synth :)

    ## Image and Video playback and production
    #obs-studio # Screen sharing
    inkscape # Vector image editing
    shotcut # Video editing
    #blender # 3D modelling
    gimp # Digital image editing
  ];

}
