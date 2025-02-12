{ pkgs, ... }:

let

  swayConfig = pkgs.writeText "greetd-sway-config" ''
    # `-l` activates layer-shell mode. Notice that `swaymsg exit` will run after gtkgreet.
    exec "${pkgs.greetd.gtkgreet}/bin/gtkgreet -l; swaymsg exit"
    bindsym Mod4+shift+e exec swaynag \
      -t warning \
      -m 'What do you want to do?' \
      -p 'Poweroff' 'systemctl poweroff' \
      -b 'Reboot' 'systemctl reboot'
  '';

in {

  services = {

    ## Login greeter/display manager,
    ## wayland native. ReGreet on top of greetd.
    greetd = {
      enable = true;
      #package = [ ];
      restart = true;
      settings = {
        default_session = {
          command = "${pkgs.sway}/bin/sway --config ${swayConfig}";
        };
      };
    };
  };

  environment = {

    etc."greetd/environments".text = ''
      sway
      fish
    '';

  };

  ## ReGreet specific configuration and theme
  programs.regreet = {
    enable = true;
    #package = [ ];

    ## Appearance
    #font = {
    #name = "Spleen-32x64";
    #size = 10;
    #package = pkgs.spleen;
    #};

    #iconTheme = {
    #name = "Flat-Remix-Grey-Darkest";
    #package = pkgs.flat-remix-icon-theme;
    #};

    #cursorTheme = {
    #name = "Bibata-Modern-Classic";
    #package = pkgs.bibata-cursors;
    #};

    #theme = {
    #name = "Colloid-Dark";
    #package = pkgs.colloid-gtk-theme;
    #};

    #extraCss = '''';

    settings = {
      # Supposed to be toml, but idk how that works, apparently this is fine ?
      # https://github.com/rharish101/ReGreet/blob/main/regreet.sample.toml
      # https://github.com/NixOS/nixpkgs/issues/335082#issuecomment-2293304283

      appearance = { # ... this is ALL appearance ? tf bruh
        greeting_msg = "Welcome !";
      };

      background = {
        path =
          "../../../home/resources/wallpapers/attunement-HelveticaBlanc.png";
        fit = "Cover";
      };

      gtk = { # why this shit needs to be declared twice i do not know
        application_prefer_dark_theme = true;
        cursor_theme_name = "Bibata-Modern-Classica";
        font_name = "Spleen-32x64 16";
        icon_theme_name = "Flat-Remix-Grey-Darkest";
        theme_name = "Colloid-Dark";
      };

      widget.clock = {
        format = "%a, %D %H:%M"; # Thursday 13/02/24, 01:36
        resolution = "500ms";
        timezone = "Australia/Brisbane";
        label_width = 150; # will need adjustment
      };

      ## Other
      commands = {
        reboot = [ "systemctl" "reboot" ];
        poweroff = [ "systemctl" "poweroff" ];
      };
    };

    cageArgs =
      [ "-s" ]; # https://github.com/cage-kiosk/cage/blob/master/cage.1.scd

  };

}
