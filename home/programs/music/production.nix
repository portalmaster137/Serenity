{ inputs, outputs, lib, config, pkgs, ... }:

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
      #supercollider-with-plugins
      #tidal # from flake ?
      bespokesynth # Modular synth and sequencer
      #vcv-rack # Analogue modular synth emulator
      #puredata # Programmatic synth and sequencer

      ## Models and synths
      #neural-amp-modeler-lv2 # Guitar amp emulator
      #cardinal # vcv-rack but as an open source VST
      #vital # Synth/VST
      #helm # Synth/VST:)

      ## Tidal Cycles stuff
      #tidal # vers. from flake input
      #vim-tidal
      #superdirt-start
      #superdirt-install
    ] ++ (with pkgs.haskellPackages; [
      #tidal # Pattern language for improvised music
      tidal # Pattern language for improvised music
      tidal-core # Core pattern library for Tidal 
      tidal-vis # Visual rendering for Tidal patterns

    ]);
  };

  ## Neovim plugins for Supercollider & Tidal Cycles
  ## - full nvim environment for supercollider is WIP
  ## - same goes for Tidal Cycles
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    nvim-treesitter-parsers.supercollider # as below for SC
    vim-tidal # tidal cycles LSP for neovim
  ];

}
