{ inputs, pkgs, label, version, lib, niri, ... }:

let
  sygil-plymouth = pkgs.stdenv.mkDerivation rec {
    pname = "sygil";
    version = "0.0.1";
    src = pkgs.fetchgit {
      url = "https://codeberg.org/serenity-F/sygil-plymouth";
      rev = "09317a6fb3";
      sha256 = "";
      fetchSubmodules = true;
    };
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/plymouth/themes/sygil
      cp -r * $out/share/plymouth/themes/sygil/
    '';
  };

in

{

  system = {
    nixos = {
      label = "${version}";
      variantName = "${label}";
    };
  };

  ## Boot/GRUB options
  boot = {
    bootspec.enable = true;
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams =
      [ # grub kernel parameters, set to prevent excessive output on boot
        "quiet" # quiet log level
        "splash" # unsure ?
        "vga=current" # use current video adapater
        "loglevel=3" # minimal output on boot
        "rd.systemd.show_status=false" # unsure ?
        "rd.udev.log_level=0" # more minimising of output on boot
        "udev.log_priority=3" # more minimising of output on boot
        "boot.shell_on_fail" # reboots to basic uefi shell on boot failure
        #"i915.fastboot=1" # unsure ?
        "plymouth.use-simpledrm" # tweak to allow plymouth animations to run smoother
        "plymouth.ignore-serial-consoles" # unsure ?
      ];
    loader = {
      timeout = 5; # 5 second timeout to default selection
      grub = {
        configurationName =
          "${version}"; # prints SerenitOS version instead of NixOS version
        splashImage = null; # hides splashimage
        timeoutStyle = "hidden"; # hides timeout
      };
    };
    plymouth = { # enables plymouth boot animations
      enable = true;
      theme = "sygil";
      themePackages = [ sygil-plymouth ];
    };
  };

  ## Display related options
  xdg.mime.enable =
    true; # may be unneeded here as already declared in `home/desktop/xdg-mime.nix`
  services.xserver.enable = true; # xserver still needed for xwayland stuff
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
    systemPackages = with pkgs; [ # theme packages
      xorg.xhost # i actually dont remember what this does
      ## Themes
      minimal-grub-theme
      #colloid-kde
      colloid-gtk-theme
      adapta-gtk-theme
      adapta-kde-theme
      materia-theme
      materia-theme-transparent
    ];
  };
  programs = { # xwayland and sway variables
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

  ## Utter junk from here on out, pls fix
  ## - - - - - - - - - - - - - - - - - - -

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

    niri = {
      enable = true;
      package = with pkgs; niri-unstable;
    };

    gnome-disks.enable = true; # For when bimbo needs to manage disks
    seahorse.enable = true; # GTK secrets management
    droidcam.enable = true; # Use android device as a webcam
    obs-studio = { # screen capture, recording, and sharing
      enable = true;
      enableVirtualCamera = true; # virtual webcam
      plugins = with pkgs.obs-studio-plugins;
        [
          #droidcam-obs # enables droidcam integration
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
