{ pkgs, ... }:

{

  imports = [

    ## Import WM/Desktop config
    ../scripts
    ./desktop

    ## Import program configs
    ./terminal
    ./chat
    ./web
    ./obs

    ## Import user themes
    ../resources/themes
    ../resources/themes/SerenityOS.nix

  ];

  home = {

    #programs.home-manager = { enable = true; };

    packages = with pkgs; [

      ## Temp.
      themix-gui # GTK theme maker

      ## Media | Chore: Pick a music player
      #lollypop # GTK music player
      spotify # Corpo music streaming
      #pragha # Music player
      #tauon # Music player

      ## Audio playback and production | Chore: Set up VSTs
      neural-amp-modeler-lv2 # Guitar amp emulator
      bespokesynth # Modular synthesiser and sequencer
      strawberry # Music playback
      metronome # A metronome
      vcv-rack # Analogue-Synth emulator
      #cardinal # VCV Rack but open source and as a plugin
      audacity # Audio editing
      reaper # DAW
      ardour # Digital Audio Workstation
      vital # synth
      helm # synth :)

      ## Image and Video playback and production
      #obs-studio # Screen sharing
      inkscape # Vector image editing
      shotcut # Video editing
      #blender # 3D modelling
      gimp # Image editor
      vlc # Multimedia player
    ];

    stateVersion = "24.11";

  };

  #systemd.user.startServices = "sd-switch";

}
