{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ## planning to have a discrete config file for
    ## the greeter(s) to keep this file tidy.
     #./regreet-config.nix
     #./sddm-config.nix
  ];

  ## xserver still needed for xwayland stuff
  services.xserver.enable = true;

  ## Current login greeter/display manager,
  ## set to run wayland.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };


  ## Eventual login greeter/display manager,
  ## wayland native.
   #services.greetd = {
       #enable = true;
       #settings.default_session = {
         #command = "${pkgs.greetd.regreet}/bin/regreet";
       #};
   #};

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
    dconf-editor # For editing dconf settings graphically 
     #xdg-utils
     #xdg-desktop-portal
     #xdg-desktop-portal-gtk
     #xdg-desktop-portal-wlr
     #xdg-desktop-portal-gnome
     #xdg-desktop-portal-hyprland
  ];

  xdg.portal = {
    enable = false;
    xdgOpenUsePortal = true;
    config = {
       #common.default = [ "gtk" "gnome" ];
       #hyprland.default = [ "gtk" "hyprland" "gnome" ];
    };
    extraPortals = with pkgs; [
       #xdg-desktop-portal-gtk
       #xdg-desktop-portal-wlr
       #xdg-desktop-portal-gnome
       #xdg-desktop-portal-hyprland
    ];
    configPackages = with pkgs; [
       #xdg-desktop-portal-gtk
       #xdg-desktop-portal-wlr
       #xdg-desktop-portal-gnome
       #xdg-desktop-portal-hyprland
    ];
  };

}
