{ config, pkgs, ... }: {

  programs.kitty = {
    enable = true;

    font = {
      name = "spleen 32x64";
      size = 11;
    };
    
    settings = {

      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
      # font_family = "spleen";
      # font_size = 12;
      cursor_shape = "Underline";
      cursor_underline_thickness = 1;
      window_padding_width = 5;
      url_style = "curly";
      confirm_os_window_close = "0";
      remember_window_size = "no";
      disable_ligatures = "never";
      shell = "${pkgs.fish}/bin/fish";
      initial_window_width = 1200;
      initial_window_height = 600;

      background = "#" + config.theme.colors.bg;
      background_opacity = "0.60";
      background_blur = 0;
      url_color = "#" + config.theme.colors.primary-fg;

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

      cursor = "#" + config.theme.colors.fg;
      cursor_text_color = "#" + config.theme.colors.bg;

      selection_foreground = "#" + config.theme.colors.primary-fg;
      selection_background = "#" + config.theme.colors.primary-bg;
    };
  };
}
