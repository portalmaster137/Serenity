{ self, inputs, ... }:

{

  # defines a custom kitty module
  flake.nixosModules.kitty =

    { pkgs, ... }:

    {

      # needed for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # home manager options
      home-manager.users.serenity = {

        # packages to include
        home.packages = with pkgs; [
          kitty
        ];

        # cli fuzzy finder
        programs.fzf = {
          enable = true;
          enableFishIntegration = true;
        };

        programs.kitty = {

          # enables kitty
          enable = true;

          # kitty integrations
          enableGitIntegration = true;
          shellIntegration.enableFishIntegration = true;

          # font settings
          font = {
            name = "spleen 32x64";
            size = 12;
          };

          # kitty settings
          settings = {

            # sets fish as the default shell
            shell = "${pkgs.fish}/bin/fish";

            # misc. settings
            url_style = "curly";
            disable_ligutures = "never";
            scrollback_lines = 10000;
            enable_audio_bell = false;
            update_check_interval = 0;

            # cursor settings
            cursor_shape = "Underline";
            cursor_shape_unfocused = "unchanged";
            cursor_underline_thickness = 1;
            cursor_trail = 1;

            # window settings
            window_padding_width = 5;
            remember_window_size = "no";
            initial_window_width = 1200;
            initial_window_height = 600;
            confirm_os_window_close = "0";
            hide_window_decorations = true;
            show_window_resize_notification = false;

            # Colours
            # NOT YET IMPLEMENTED
            background_blur = 2;
            background_opacity = "0.82";

          };

          # misecellaneous kitty config
          extraConfig = ''
            window_padding_width 5 0
          '';

        };

      };

    };

}
