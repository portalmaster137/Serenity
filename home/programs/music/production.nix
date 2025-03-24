{ pkgs, ... }:

{

  home = {
    packages = with pkgs; [

      ## Misc. Tools
      metronome # GTK metronome

      ## Text based programmatic music production
      supercollider-with-plugins

      ## Visual node based audio production
      bespokesynth # Modular synth and sequencer
      vcv-rack # Analogue modular synth emulator
      puredata # Programmatic synth and sequencer

      ## Digital Audio Workstations
      audacity # Audio editing and DAW
      reaper # Digital audio workstation
      ardour # Digital Audio Workstation

      ## Models and synths
      neural-amp-modeler-lv2 # Guitar amp emulator
      cardinal # vcv-rack but as an open source VST
      vital # Synth/VST
      helm # Synth/VST:)

    ];
  };

  ## Neovim plugins for Supercollider synth
  programs.nixvim.extraPlugins = with pkgs.vimPlugins;
    [ nvim-treesitter-parsers.supercollider ];

}
