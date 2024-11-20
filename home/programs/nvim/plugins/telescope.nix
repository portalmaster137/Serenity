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
    plugins.telescope = {
      enable = true;
      extensions.fzf-native = { enable = true; };
      settings.defaults = { selection_caret = "❚ "; };
    };
  };
}
