{ config, pkgs, ... }: {
  programs.nixvim = {
    highlightOverride = { FloatBorder.fg = "#${config.theme.colors.color15}"; };

    plugins = {

      comment.enable = true;
      todo-comments.enable = true;
      tmux-navigator.enable = true;
      nvim-autopairs.enable = true;
      friendly-snippets.enable = true;

      flash.enable = true;
      image = {
        enable = true;
        settings.integrations.markdown = {
          clearInInsertMode = true;
          onlyRenderImageAtCursor = true;
        };
      };

      treesitter = {
        enable = true;
        nixGrammars = true;
        settings = {
          indent.enable = true;
          highlight.enable = true;
        };
      };

      harpoon = {
        enable = true;
        enableTelescope = true;
        #keymapsSilent = true;
        #keymaps = {
        #addFile = "<leader>ha";
        #toggleQuickMenu = "<leader>hu";
        #navNext = "<leader>hl";
        #navPrev = "<leader>hh";
        #navFile = {
        #"1" = "<leader>h1";
        #"2" = "<leader>h2";
        #"3" = "<leader>h3";
        #"4" = "<leader>h4";
        #};
        #};
      };

      dap = {
        enable = true;
        adapters = { };
        signs = {
          dapBreakpoint = {
            text = "●";
            texthl = "DapBreakpoint";
          };
          dapBreakpointCondition = {
            text = "●";
            texthl = "DapBreakpointCondition";
          };
          dapLogPoint = {
            text = "◆";
            texthl = "DapLogPoint";
          };
        };
      };

      dap-ui = { enable = true; };
      dap-virtual-text = { enable = true; };
      dap-go = {
        enable = true;
        settings = { delve.path = "${pkgs.delve}/bin/dlv"; };
      };

    };
  };
}
