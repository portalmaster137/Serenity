{ config, pkgs, ... }:

let

  accent = "#${config.theme.colors.color14}";
  muted = "#${config.theme.colors.secondary-bg}";
  foreground = "#${config.theme.colors.primary-fg}";

in {

  home.packages = with pkgs; [ ctags ];

  programs = {
    nixvim = {

      dependencies.ctags = {
        enable = true;
        #package = with pkgs; [ universal-ctags ];
      };

      highlight = {
        AlphaHeaderColor.fg = accent;
        AlphaTextColor.fg = foreground;
        AlphaShortcutColor.fg = muted;
      };

      colorschemes = {
        modus = {
          enable = true;
          settings = {
            transparent = true;
            style = "modus_vivendi";
            styles = {
              comments = {
                italic = true;
                #bg = "";
                fg = "#cccccc";
              };
              variables = {
                #bg = "";
                fg = "#00c0ff";
              };
              functions = {
                #bg = "";
                fg = "#d0fffe";
              };
              keywords = {
                bold = true;
                #bg = "";
                fg = "#00dfff";
              };
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
          settings = { level = "warn"; };
        };
        gitsigns = {
          enable = true;
          settings.current_line_blame = false;
        };

        trouble.enable = true;
        indent-blankline.enable = true;
        colorizer.enable = true;
        tagbar = {
          enable = true;
          #tagsPackage = pkgs.universal-ctags;
        };

        alpha = {
          enable = true;
          layout = [
            {
              type = "padding";
              val = 4;
            }
            {
              type = "text";
              opts = {
                position = "center";
                hl = "AlphaHeaderColor";
              };
              val = [
                "                                                                     "
                "       ████ ██████           █████      ██                     "
                "      ███████████             █████                             "
                "      █████████ ███████████████████ ███   ███████████   "
                "     █████████  ███    █████████████ █████ ██████████████   "
                "    █████████ ██████████ █████████ █████ █████ ████ █████   "
                "  ███████████ ███    ███ █████████ █████ █████ ████ █████  "
                " ██████  █████████████████████ ████ █████ █████ ████ ██████ "
                "                                                                       "
              ];
            }
            {
              type = "padding";
              val = 4;
            }
            {
              type = "group";
              val = [
                {
                  type = "button";
                  val = "󰭎  Find file";
                  on_press.__raw =
                    "function() vim.cmd[[Telescope find_files]] end";
                  opts = {
                    shortcut = "nf";
                    position = "center";
                    cursor = 3;
                    width = 50;
                    align_shortcut = "right";
                    hl_shortcut = "AlphaShortcutColor";
                    hl = "AlphaTextColor";
                  };
                }
                {
                  type = "button";
                  val = "  New file";
                  on_press.__raw = "function() vim.cmd[[ene]] end";
                  opts = {
                    shortcut = "nn";
                    position = "center";
                    cursor = 3;
                    width = 50;
                    align_shortcut = "right";
                    hl_shortcut = "AlphaShortcutColor";
                    hl = "AlphaTextColor";
                  };
                }
                {
                  type = "button";
                  val = "  NixOs Config";
                  on_press.__raw =
                    "function() vim.cmd[[Neotree /home/serenity/flakes/nixdots/home/common/dotconfig/nvim]] end";
                  opts = {
                    shortcut = "nc";
                    position = "center";
                    cursor = 3;
                    width = 50;
                    align_shortcut = "right";
                    hl_shortcut = "AlphaShortcutColor";
                    hl = "AlphaTextColor";
                  };
                }
                {
                  type = "button";
                  val = "  Keybindings";
                  on_press.__raw =
                    "function() vim.cmd[[e /home/serenity/flakes/nixdots/home/common/dotconfig/nvim/docs/KEYBINDINGS.md]] end";
                  opts = {
                    shortcut = "nc";
                    position = "center";
                    cursor = 3;
                    width = 50;
                    align_shortcut = "right";
                    hl_shortcut = "AlphaShortcutColor";
                    hl = "AlphaTextColor";
                  };
                }
                {
                  type = "button";
                  val = "  Recently used";
                  on_press.__raw =
                    "function() vim.cmd[[Telescope oldfiles]] end";
                  opts = {
                    shortcut = "no";
                    position = "center";
                    cursor = 3;
                    width = 50;
                    align_shortcut = "right";
                    hl_shortcut = "AlphaShortcutColor";
                    hl = "AlphaTextColor";
                  };
                }
                {
                  type = "button";
                  val = "󰱽  Find text";
                  on_press.__raw =
                    "function() vim.cmd[[Telescope live_grep]] end";
                  opts = {
                    shortcut = "nt";
                    position = "center";
                    cursor = 3;
                    width = 50;
                    align_shortcut = "right";
                    hl_shortcut = "AlphaShortcutColor";
                    hl = "AlphaTextColor";
                  };
                }
                {
                  type = "button";
                  val = "󰩈  Quit Neovim";
                  on_press.__raw = "function() vim.cmd[[qa]] end";
                  opts = {
                    shortcut = "nq";
                    position = "center";
                    cursor = 3;
                    width = 50;
                    align_shortcut = "right";
                    hl_shortcut = "AlphaShortcutColor";
                    hl = "AlphaTextColor";
                  };
                }
              ];

            }
          ];
        };
      };
    };
  };

}
