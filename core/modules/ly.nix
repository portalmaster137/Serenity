{ config, pkgs, lib, ... }:

let

  swayConfig = pkgs.writeText "greetd-sway-config" ''
    # `-l` activates layer-shell mode. Notice that `swaymsg exit` will run after gtkgreet.
    exec "${pkgs.greetd.gtkgreet}/bin/gtkgreet -l; swaymsg exit"
    bindsym Mod4+shift+e exec swaynag \
      -t warning \
      -m 'What do you want to do?' \
      -b 'Poweroff' 'systemctl poweroff' \
      -b 'Reboot' 'systemctl reboot'
  '';

in {

  services = {

    ## Eventual login greeter/display manager,
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

    #cageArgs = [ "-s" "-m" "last" ];

    #settings = { };

    font = {
      name = "Spleen-32x64";
      size = 10;
      package = pkgs.spleen;
    };

    theme = lib.mkForce {
      name = "Colloid-Dark";
      package = pkgs.colloid-gtk-theme;
    };

    #extraCss = "";

    iconTheme = {
      name = "Flat-Remix-Grey-Darkest";
      package = pkgs.flat-remix-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };
  };

}
