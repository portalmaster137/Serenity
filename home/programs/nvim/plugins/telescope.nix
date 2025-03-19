{ config, ... }:
let
  accent = "#${config.theme.colors.color15}";
  background = "#${config.theme.colors.primary-bg}";
  background-alt = "#${config.theme.colors.secondary-bg}";
in {
  programs.nixvim = {
    highlight = {
      TelescopePromptPrefix.fg = accent;
      TelescopeSelectionCaret = {
        fg = accent;
        bg = background-alt;
      };
      TelescopeSelection.bg = background-alt;
      TelescopePromptTitle = {
        bg = background;
        fg = accent;
      };
      TelescopePromptNormal.bg = background;
      TelescopePromptBorder = {
        bg = background;
        fg = accent;
      };
    };
    plugins = {
      telescope = {
        enable = true;
        extensions.fzf-native = { enable = true; };
        settings.defaults = { selection_caret = "❚ "; };
      };

      ## Tree
      treesitter-context.enable = true;
      neo-tree.enable = true;
      oil = {
        enable = true;
        settings = {
          default_file_explorer = false;
          skip_confirm_for_simple_edits = true;
          win_options = {
            concealcursor = "ncv";
            conceallevel = 3;
            cursorcolumn = false;
            foldcolumn = "0";
            list = false;
            signcolumn = "no";
            spell = false;
            wrap = false;
          };
          float = { padding = 5; };
          keymaps = {
            "-" = "actions.parent";
            "b" = "actions.parent";
            "<C-c>" = "actions.close";
            "<C-h>" = "actions.select_split";
            "<C-l>" = "actions.refresh";
            "<C-p>" = "actions.preview";
            "<C-s>" = "actions.select_vsplit";
            "<C-t>" = "actions.select_tab";
            "<CR>" = "actions.select";
            _ = "actions.open_cwd";
            "`" = "actions.cd";
            "g." = "actions.toggle_hidden";
            "g?" = "actions.show_help";
            "g\\" = "actions.toggle_trash";
            gs = "actions.change_sort";
            gx = "actions.open_external";
            "~" = "actions.tcd";
          };
        };
      };

    };
  };
}
