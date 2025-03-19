{ pkgs, ... }: {

  imports = [ ];

  home.packages = with pkgs; [
    supercollider-with-plugins
    puredata-with-plugins
  ];

  ## Supercollider config
  programs = {

    nixvim = {
      ## Enables nvim treesitter for supercollider
      extraPlugins = with pkgs.vimPlugins;
        [ nvim-treesitter-parsers.supercollider ];
    };

  };

}
