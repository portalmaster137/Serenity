{ self, inputs, ... }: {

  # wofi launcher module declaration
  flake.nixosModules.wofi = { config, ... }: {

    # for home manager functionality
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    # home manager options
    home-manager.user.serenity = {

      # enables wofi
      programs.wofi = {
        enable = true;

        # wofi settings
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
          allow_images = true;
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
          disable_prime = false;
        };

        # NOT YET IMPLEMENTED
        # wofi theme
        #style = '' '';
      };
    };
  };
}
