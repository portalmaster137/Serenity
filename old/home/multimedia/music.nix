{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:

{

  home = {
    packages = with pkgs; [

      ## Chore: pick an offline music player already lol
      ## Requirements:
      ## - have last.fm support
      ## - match other UI styles
      ## - handle large amounts of FLAC/HiRes audio
      ## - optionally support metadata editing

      # Music players
      spotify # corpo trash
      strawberry # QT music player
      #lollypop # GTK/Gnome native music player
      #pragha # Music player
      #tauon # Music player

      # Music Production
      easyeffects # Effects and DSP
      pavucontrol # Precise volume control
      crosspipe # patchbay and routing
      #neural-amp-modeler-lv2 # Guitar amp emulator
      metronome # GTK metronome
      bespokesynth # DAW/Synth
      audacity # Audio editing and DAW
      cardinal # Synth/VST
      reaper # DAW
      ardour # DAW
      vital # Synth/VST
      helm # Synth/VST

      # Misc. Tools
      puddletag # Music metadata editor
      libjack2 # unsure
      zenity # unsure
      glfw # unsure

      # Tidal/Supercollider
      #supercollider-with-plugins
      #tidal # vers. from flake input
      #vim-tidal
      #superdirt-start
      #superdirt-install
    ]; # ++ (with pkgs.haskellPackages; [
    #tidal # Pattern language for improvised music
    #tidal # Pattern language for improvised music
    #tidal-core # Core pattern library for Tidal
    #tidal-vis # Visual rendering for Tidal patterns
    #]);
  };

  ## Neovim plugins for Supercollider & Tidal Cycles
  ## - full nvim environment for supercollider is WIP
  ## - same goes for Tidal Cycles
  #programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
  #nvim-treesitter-parsers.supercollider # as below for SC
  #vim-tidal # tidal cycles LSP for neovim
  #];

}
