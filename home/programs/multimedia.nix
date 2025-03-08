{ pkgs, ... }:

{

  home = {
    packages = with pkgs; [

      ## Media | Chore: Pick a music player
      strawberry # QT music player
      #lollypop # GTK music player
      spotify # Corpo music streaming
      #pragha # Music player
      #tauon # Music player

      ## Audio playback and production | Chore: Set up VSTs
      neural-amp-modeler-lv2 # Guitar amp emulator
      bespokesynth # Modular synthesiser and sequencer,
      # holy shit, y'all, bespoke is SO good :D
      puddletag # Music metadata editing
      metronome # A metronome
      vcv-rack # Analogue-Synth emulator
      #cardinal # VCV Rack but open source and as a plugin
      audacity # Audio editing
      reaper # DAW
      ardour # Digital Audio Workstation
      vital # Synth/VST
      helm # Synth/VST:)

      ## Image and Video playback and production
      #obs-studio # Screen sharing
      inkscape # Vector image editing
      shotcut # Video editing
      #blender # 3D modelling
      gimp # Image editor
      vlc # Multimedia player

    ];
  };

}
