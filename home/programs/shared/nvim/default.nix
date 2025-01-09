{ inputs, ... }: {

  imports = [

    inputs.nixvim.homeManagerModules.nixvim # uses the module channel from `flake.nix`
    ./keymaps.nix # keybinds

    ## Neovim plugins
    ./plugins/utils.nix
    ./plugins/ui.nix
    ./plugins/lsp.nix
    ./plugins/markdown.nix
    ./plugins/telescope.nix
  ];

  ## Enables nixvim
  programs = {

    nixvim = {
      enable = true;
      globals = { mapleader = " "; };

      opts = {
        updatetime = 50; # Faster completion
        number = true;
        relativenumber = true;
        autoindent = true;
        clipboard = "unnamed,unnamedplus";
        expandtab = true;
        tabstop = 2;
        softtabstop = 2;
        shiftwidth = 2;
        smartindent = true;
        breakindent = true;
        ignorecase = true;
        incsearch = true;
        hlsearch = true;
        smartcase = true;
        wildmode = "list:longest";
        completeopt = [ "menuone" "noselect" "noinsert" ];
        signcolumn = "yes";
        cursorline = false;
        scrolloff = 8;
        mouse = "a";
        termguicolors = true;
        showmode = false;
        wrap = false;
        swapfile = false;
        undofile = true;
        conceallevel = 3;

      };
    };

  };

}
