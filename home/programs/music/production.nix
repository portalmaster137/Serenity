{ pkgs, ... }:

{

  home = {
    packages = with pkgs; [

      ## Misc. Tools
      glfw-wayland
      libjack2
      zenity
      metronome # GTK metronome

      ## Digital Audio Workstations
      audacity # Audio editing and DAW
      reaper # Digital audio workstation
      ardour # Digital Audio Workstation

      ## Modular and programmatic music production
      supercollider-with-plugins
      bespokesynth # Modular synth and sequencer
      vcv-rack # Analogue modular synth emulator
      puredata # Programmatic synth and sequencer

      ## Models and synths
      neural-amp-modeler-lv2 # Guitar amp emulator
      #cardinal # vcv-rack but as an open source VST
      #vital # Synth/VST
      #helm # Synth/VST:)

    ];
  };

  ## Neovim plugins for Supercollider synth
  ## - full nvim environment for supercollider is WIP
  programs.nixvim.extraPlugins = with pkgs.vimPlugins;
    [ nvim-treesitter-parsers.supercollider ];

}
