{ pkgs, ... }:

{

  home = {
    packages = with pkgs; [

      ## Audio playback and production | Chore: Set up VSTs
      neural-amp-modeler-lv2 # Guitar amp emulator
      bespokesynth # Modular synthesiser and sequencer,
      metronome # A metronome
      vcv-rack # Analogue-Synth emulator
      #cardinal # VCV Rack but open source and as a plugin
      audacity # Audio editing
      reaper # DAW
      ardour # Digital Audio Workstation
      vital # Synth/VST
      helm # Synth/VST:)

    ];
  };

}
