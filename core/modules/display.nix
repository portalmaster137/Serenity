{ pkgs, ... }:

{
  imports = [
    ## planning to have a discrete config file for
    ## the greeter(s) to keep this file tidy.
    ./regreet.nix
  ];

  boot = {

    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

    loader = {
      timeout = 0;

      grub = {
        theme = "${pkgs.minimal-grub-theme}";
        backgroundColor = "#000000";
        #splashImage = "path/to/image";
        #font = "${pkgs.spleen}/share/fonts/spleen-32x64";
        #fontSize = 16;
      };

    };

    plymouth = {
      enable = true;

      #logo = pkgs.fetchurl {
        #url = "https://nixos.org/logo/nixos-hires.png";
        #hash = "1ivzgd7iz0i06y36p8m5w48fd8pjqwxhdaavc0pxs7w1g7mcy5si";
      #};
      #font = "${pkgs.spleen}/share/fonts/spleen-32x64";

      theme = "circle";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [
            "circle"
            "circuit"

          ];
        })
      ];

      #extraConfig = '''';

    };

  };

  services = {

    ## xserver still needed for xwayland stuff
    xserver.enable = true;

  };

  programs = {

    ## Standard(?) xwayland implementation
    xwayland = {
      enable = true;
       #package = [ ];
       #defaultFontPath = "/run/current-system/sw/share/X11/fonts";
    };

    ## enable sway window manager
    sway = {
      enable = true;
      ## Sways implementation of xwayland
      #xwayland.enable = true;
      package = pkgs.swayfx;
      extraPackages = [ ];
      wrapperFeatures = {
        gtk = true;
        base = true;
      };
      extraSessionCommands = ''
        export SDL_VIDEODRIVER=wayland
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        export XDG_CURRENT_DESKTOP=sway
        export XDG_SESSION_TYPE=wayland
      '';
    };
  };

  ## To start sway related services
  systemd.user.targets.sway = {
    description = "to start sway related services";
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
  };
  
  xdg = {
    portal = {
     #enable = true;
     #xdgOpenUsePortal = true;
      #config = {
        #common."org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        #common.default = [ "gtk" "gnome" ];
        #sway.default = [ "gtk" "gnome" ];
      #};
      #configPackages = with pkgs; [
        #xdg-desktop-portal-gtk
        #xdg-desktop-portal-wlr
        #xdg-desktop-portal-gnome
      #];
      #extraPortals = with pkgs; [
        #xdg-desktop-portal-gtk
        #xdg-desktop-portal-wlr
        #xdg-desktop-portal-gnome
      #];
    };
  };

  environment = {

    variables = {
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "sway";
    };

    systemPackages = with pkgs; [
      minimal-grub-theme
      xorg.xhost
      #qt5.wayland
      #xdg-utils
      #xdg-desktop-portal
      #xdg-desktop-portal-gtk
      #xdg-desktop-portal-wlr
      #xdg-desktop-portal-gnome
    ];

  };

  ## I put fonts here because i didn't know where tf else to put them lol
  ## duplicate to home-manager config
  fonts = {
    packages = with pkgs; [
      spleen
      terminus_font
      terminus_font_ttf
      nerd-fonts.symbols-only
    ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
    fontDir.enable = true;
    fontconfig = {
      defaultFonts = {
        serif = [ "spleen-32x64" ];
        sansSerif = [ "spleen-32x64" ];        
        monospace = [ "TerminusTTF" ];
      };
    };
  };



}
