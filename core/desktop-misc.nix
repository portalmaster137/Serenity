{ self, inputs, outputs, lib, config, pkgs, ... }:

{

  imports = [
  ];

  ## Dunno if i did this right, but possible needed for keyring/polkit stuff ? 
  security.pam.services.serenity.enableGnomeKeyring = true;

  programs = {
    ## For when bimbo needs to play with platters and cbf to deal with cli
    gnome-disks.enable = true;
    ## GTK secrets management
    seahorse.enable = true;
    ## Use android device as a webcam
    droidcam.enable = true;
    ## Apparently nm-applet has a programs option
     #nm-applet = {
       #enable = true;
       #indicator = false;
     #};
    ## idk something for nautilus
     #nautilus-open-any-terminal = {
       #enable = true;
       #terminal = "kitty";
     #};
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = with pkgs.obs-studio-plugins; [
        droidcam-obs
      ];
    };

    dconf.enable = false;
  };

  services = {
    libinput.enable = true;
    ## Virtual filesystem, needed this for something i think ?
    gvfs.enable = true;
    dbus.enable = true;
    upower.enable = true;
    udisks2.enable = true;
    power-profiles-daemon.enable = true;
    gnome = {
      ## File previewer for nautilus
      sushi.enable = true;
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

  environment.systemPackages = with pkgs; [
  ];

}
