{ config, pkgs, ... }:

{

  home = { packages = with pkgs; [ kitty ]; };

  #programs.alacritty.enable = true;

  ## Enables kitty via home-manager
  programs.kitty = {
    enable = true;

    ## Declares "spleen" as the font
    font = {
      name = "spleen 32x64";
      size = 11;
    };

    ## Unsure if this is needed, but it should enhance fish integration ?
    shellIntegration.enableFishIntegration = true;

    settings = {

      ## This enables fish as the default shell
      shell = "${pkgs.fish}/bin/fish";

      ## Misc.
      url_style = "curly";
      scrollback_lines = 10000;
      disable_ligatures = "never";
      enable_audio_bell = false;
      update_check_interval = 0;
      confirm_os_window_close = "0";

      ## Cursor
      cursor_shape = "Underline";
      cursor_underline_thickness = 1;
      cursor_shape_unfocused = "unchanged";

      ## Window
      window_padding_width = 5;
      initial_window_width = 1200;
      initial_window_height = 600;
      remember_window_size = "no";

      ## Colours
      cursor = "#" + config.theme.colors.fg;
      cursor_text_color = "#" + config.theme.colors.bg;
      background = "#" + config.theme.colors.bg;
      background_blur = 0;
      background_opacity = "0.70";
      selection_foreground = "#" + config.theme.colors.primary-fg;
      selection_background = "#" + config.theme.colors.primary-bg;
      url_color = "#" + config.theme.colors.primary-fg;

      ## Declared in home/resources/themes/${themeName}
      color0 = "#" + config.theme.colors.color0;
      color8 = "#" + config.theme.colors.color8;
      color1 = "#" + config.theme.colors.color1;
      color9 = "#" + config.theme.colors.color9;
      color2 = "#" + config.theme.colors.color2;
      color10 = "#" + config.theme.colors.color10;
      color3 = "#" + config.theme.colors.color3;
      color11 = "#" + config.theme.colors.color11;
      color4 = "#" + config.theme.colors.color4;
      color12 = "#" + config.theme.colors.color12;
      color5 = "#" + config.theme.colors.color5;
      color13 = "#" + config.theme.colors.color13;
      color6 = "#" + config.theme.colors.color6;
      color14 = "#" + config.theme.colors.color14;
      color7 = "#" + config.theme.colors.color7;
      color15 = "#" + config.theme.colors.color15;

    };
  };
}
