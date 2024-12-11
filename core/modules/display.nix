{ inputs, pkgs, ... }:

{
  imports = [
    ## planning to have a discrete config file for
    ## the greeter(s) to keep this file tidy.
     #./regreet-config.nix
     #./sddm-config.nix
  ];

  services = {

    ## xserver still needed for xwayland stuff
    xserver.enable = true;

    ## Current login greeter/display manager,
    ## set to run wayland.
    displayManager = {
      enable = true;
       #defaultSession = "sway";
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };

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
  

  environment = {
    variables = {
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "sway";
    };
    systemPackages = with pkgs; [
      xorg.xhost
      #dconf # redundant, adding for completeness
      dconf-editor # For editing dconf settings graphically
      #qt5.wayland
      #xdg-utils
      #xdg-desktop-portal
      #xdg-desktop-portal-gtk
      #xdg-desktop-portal-wlr
      #xdg-desktop-portal-gnome
      #xdg-desktop-portal-hyprland
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

   #xdg.portal = {
     #enable = true;
     #xdgOpenUsePortal = true;
     #config = {
       #common."org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
       #common.default = [ "gtk" "gnome" ];
       #sway.default = [ "gtk" "gnome" ];
       #hyprland.default = [ "hyprland" "gtk" "gnome" ];
     #};
     #configPackages = with pkgs; [
       #xdg-desktop-portal-gtk
       #xdg-desktop-portal-wlr
       #xdg-desktop-portal-gnome
       #xdg-desktop-portal-hyprland
     #];
     #extraPortals = with pkgs; [
       #xdg-desktop-portal-gtk
       #xdg-desktop-portal-wlr
       #xdg-desktop-portal-gnome
       #xdg-desktop-portal-hyprland
     #];
   #};

}
