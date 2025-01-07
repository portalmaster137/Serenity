{ pkgs, ... }:

{

  imports = [

    ## Import program configs
    #./syncthing
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

    ## Temp.
    themix-gui # GTK theme maker

    ## Games
    osu-lazer-bin # Rhythm is just a click away!
    cockatrice # Magical the gathering but free
    vassal # FOSSy board-game sim :3
    #retroarch
    retroarchFull
    libretro.citra
    libretro.pcsx2
    libretro.swanstation

    ## Chat & Web
    telegram-desktop
    lagrange # Browser for the gemini protocol
    vesktop # Modded discord wrapper
    fractal # GTK matrix client | Broken: Fix gnome-keyring
    tor # The Onion Router

    ## Media | Chore: Pick a music player
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
    virtualbox # emulator - for wimdose
    obsidian # Note-taking

    ## Audio playback and production | Chore: Set up VSTs
    neural-amp-modeler-lv2 # Guitar amp emulator
    bespokesynth # Modular synthesiser and sequencer
    easyeffects # EQ and audio effects
    strawberry # Music playback
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
