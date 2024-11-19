{ pkgs, config, ... }: {
  home.packages = with pkgs; [ ctags ];

  programs.nixvim = {
    colorschemes.modus = {
      enable = true;
      settings = {
        transparent = true;
        style = "modus_vivendi";
        styles = {
          comments = {
            italic = true;
            #bg = "";
            fg = "${config.theme.colors.alt-fg}";
          };
          variables = {
            #bg = "";
            fg = "{config.theme.colors.primary-bg}";
          };
          functions = {
            #bg = "";
            fg = "{config.theme.colors.fg}";
          };
          keywords = {
            bold = true;
            #bg = "";
            fg = "{config.theme.colors.secondary-bg}";
          };
        };
      };
    };
    plugins = {
      #transparent.enable = true;
      lualine = {
        enable = true;
        settings = {
          options.disabled_filetypes.statusline =
            [ "dashboard" "alpha" "neo-tree" ];

          alwaysDivideMiddle = true;
          globalstatus = true;
          ignoreFocus = [ "neo-tree" ];
          extensions = [ "fzf" ];
          theme = "auto";
          componentSeparators = {
            left = "|";
            right = "|";
          };
          sectionSeparators = {
            left = "█"; # 
            right = "█"; # 
          };
          sections = {
            lualine_a = [ "mode" ];
            lualine_b = [ "branch" "diff" "diagnostics" ];
            lualine_c = [ "filename" ];
            lualine_x = [ "filetype" ];
            lualine_y = [ "progress" ];
            lualine_z = [ ''" " .. os.date("%R")'' ];
          };
        };
      };
      web-devicons.enable = true;
      noice.enable = true;
      notify = {
        enable = true;
        level = "warn";
      };
      gitsigns = {
        enable = true;
        settings.current_line_blame = false;
      };
      trouble.enable = true;
      indent-blankline.enable = true;
      nvim-colorizer.enable = true;
      tagbar = {
        enable = true;
        tagsPackage = pkgs.universal-ctags;
      };
    };
  };
}
