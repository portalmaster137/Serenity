{ config, ... }: {

  programs.wofi = {
    enable = true;

    settings = {
      term = "kitty";
      show = "drun";
      width = 500;
      height = 300;
      prompt = "Programs";
      normal_window = true;
      key_exit = "Escape";
      key_expand = "Tab";
      layer = "top";
      gtk_dark = true;
      orientation = "vertical";
      halign = "fill";
      line_wrap = "off";
      dynamic_lines = false;
      allow_markup = true;
      allow_images = false;
      image_size = 24;
      hide_scroll = true;
      hide_search = false;
      exec_search = false;
      parse_search = false;
      insensitive = true;
      no_actions = true;
      sort_order = "default";
      filter_rate = 100;
      ## Steam not launching from wofi, but will launch in terminal
      ## See: core/modules/gaming.nix
      ## https://github.com/ValveSoftware/steam-for-linux/issues/9940
      disable_prime = true;
    };

    style = ''
      /** ********** Fonts ********** **/

      * {
        font-family: "${config.theme.font}";
        font-weight: 500;
        font-size: 12px;
      }

      #window {
        background-color: #${config.theme.colors.alt-bg};
        color: #${config.theme.colors.alt-fg};
        border-radius: ${toString config.theme.rounding}px;
      }

      #outer-box {
        padding: 20px;
      }

      #input {
        background-color: #${config.theme.colors.bg};
        border: 0px solid #${config.theme.colors.primary-bg};
        padding: 8px 12px;
      }

      #scroll {
        margin-top: 20px;
      }

      #inner-box {}

      #img {
        padding-right: 8px;
      }

      #text {
        color: #${config.theme.colors.color7};
      }

      #text:selected {
        color: #${config.theme.colors.fg};
      }

      #entry {
        padding: 6px;
      }

      #entry:selected {
        background-color: #${config.theme.colors.primary-bg};
        color: #${config.theme.colors.primary-fg};
      }

      #unselected {}

      #selected {}

      #input,
      #entry:selected {
        border-radius: ${toString (config.theme.rounding - 10)}px;
      }
    '';
  };
}
