{ inputs, outputs, lib, config, pkgs, ... }:

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
    ## Eventual login greeter/display manager,
    ## wayland native.
     #greetd = {
        #enable = true;
        #settings.default_session = {
          #command = "${pkgs.greetd.regreet}/bin/regreet";
        #};
     #};

    ## Virtual filesystem, needed this for something i think ?
    gvfs.enable = true;
    gnome = {
      ## File previewer for nautilus
      sushi.enable = true
      ## "core utilities"
      core-utilities.enable = true;
      ## GNOME keyring
      gnome-keyring.enable = true;
      ## Makes all of /Public available over network
      gnome-user-share.enable = true;
      ## GUI system settings ?
      gnome-settings-daemon.enable = true;
    };

  };

  ## Dunno if i did this right, but possible needed for keyring/polkit stuff ? 
  security.pam.services.serenity.enableGnomeKeyring = true;

  programs = {

    ## Eventual login greeter/display manager,
    ## wayland native.
     #regreet.enable = true;
    
    dconf = {
      enable = true;
    };

    ## Standard(?) xwayland implementation
    xwayland = {
      enable = true;
       #package = [ ];
       #defaultFontPath = "/run/current-system/sw/share/X11/fonts";
    };

    ## Temporary, fuck vaxery or whatever his name is
    ## punk-ass motherfucker, swayfx looks neat
    hyprland = {
      enable = true;
      ## Hyprland's implementation of xwayland
       #xwayland.enable = true;
    };
    
    ## enable sway window manager
    sway = {
      enable = true;
      ## Sways implementation of xwayland
       #xwayland.enable = true;
      package = pkgs.swayfx;
      wrapperFeatures.gtk = true;
    };
  };

  environment.systemPackages = with pkgs; [
    xorg.xhost
     #dconf # redundant, adding for completeness
    dconf-editor # For editing dconf settings graphically 
     #xdg-utils
     #xdg-desktop-portal
     #xdg-desktop-portal-gtk
     #xdg-desktop-portal-wlr
     #xdg-desktop-portal-gnome
     #xdg-desktop-portal-hyprland
  ];

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

  ## I put fonts here because i didn't know where tf else to put them lol
  ## CURRENTLY BROKEN, PLEASE FIX - Out of date ?
  fonts = {
    packages = with pkgs; [
      spleen
      terminus_font
      terminus_font_ttf
      (nerdfonts.override { fonts = ["NerdFontsSymbolsOnly"]; })  	  
    ];
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
