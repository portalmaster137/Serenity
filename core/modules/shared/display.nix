{ pkgs, ... }:

{

  boot = {
    bootspec.enable = true;
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "vga=current"
      #"loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "boot.shell_on_fail"
    ];
    loader = {
      timeout = 30;
      #grub = {
      #theme = "${pkgs.minimal-grub-theme}";
      #backgroundColor = "#000000";
      #splashImage = "path/to/image";
      #font = "${pkgs.spleen}/share/fonts/spleen-32x64";
      #fontSize = 16;
      #};
    };
    plymouth = {
      enable = true;
      #logo = pkgs.fetchurl {
      #url = "https://nixos.org/logo/nixos-hires.png";
      #hash = "1ivzgd7iz0i06y36p8m5w48fd8pjqwxhdaavc0pxs7w1g7mcy5si";
      #};
      #font = "${pkgs.spleen}/share/fonts/spleen-32x64";
      theme = "circle";
      themePackages = with pkgs;
        [
          (adi1090x-plymouth-themes.override {
            selected_themes = [ "circle" ];
          })
        ];
      #extraConfig = '''';
    };
  };

  xdg.mime.enable =
    true; # may be unneeded here as already declared in `home/desktop/xdg-mime.nix`

  services = {
    xserver.enable = true; # xserver still needed for xwayland stuff
  };

  systemd.user.targets.sway = { # To start sway related services
    description = "to start sway related services";
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
  };

  environment = {
    variables = { # environment variables, duh
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "sway";
    };
    systemPackages = with pkgs; [
      xorg.xhost # i actually dont remember what this does
      ## Themes
      minimal-grub-theme
      colloid-kde
      colloid-gtk-theme
      adapta-gtk-theme
      adapta-kde-theme
      materia-theme
      materia-theme-transparent
    ];
  };

  programs = {
    xwayland = { # Standard(?) xwayland implementation
      enable = true;
      #package = [ ];
      #defaultFontPath = "/run/current-system/sw/share/X11/fonts";
    };
    sway = { # enable sway window manager
      enable = true;
      package = pkgs.swayfx;
      extraPackages = [ ];
      wrapperFeatures = {
        gtk = true;
        base = true;
      };
      extraSessionCommands = ''
        export SDL_VIDEODRIVER=wayland,windows
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        export XDG_CURRENT_DESKTOP=sway
        export XDG_SESSION_TYPE=wayland
      '';
    };
  };

  ## I put fonts here because i didn't know where tf else to put them lol
  ## duplicate to home-manager config ?
  fonts = {
    packages = with pkgs;
      [ spleen terminus_font terminus_font_ttf nerd-fonts.symbols-only ]
      ++ builtins.filter lib.attrsets.isDerivation
      (builtins.attrValues pkgs.nerd-fonts);
    fontDir.enable = true;
    fontconfig = {
      defaultFonts = {
        serif = [ "spleen-32x64" ];
        sansSerif = [ "spleen-32x64" ];
        monospace = [ "TerminusTTF" ];
      };
    };
  };

  ## Dunno if i did this right, but possible needed for keyring/polkit stuff ? 
  security.pam.services.serenity.enableGnomeKeyring = true;

  programs = {
    gnome-disks.enable = true; # For when bimbo needs to manage disks
    seahorse.enable = true; # GTK secrets management
    droidcam.enable = true; # Use android device as a webcam
    obs-studio = { # screen capture, recording, and sharing
      enable = true;
      enableVirtualCamera = true; # virtual webcam
      plugins = with pkgs.obs-studio-plugins;
        [
          droidcam-obs # enables droidcam integration
        ];
    };

  };

  services = {
    libinput.enable = true; # don't think we NEED this tbh - unsure
    gvfs.enable = true; # virtual filesystem, needed this for ... something
    dbus.enable = true; # dbus is for ... unsure
    upower.enable = true; # no clue
    udisks2.enable = true; # disk management service
    gnome.gnome-keyring.enable = true; # for sudo prompts and stuff
  };

}
