{ pkgs, ... }:

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
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = with pkgs.obs-studio-plugins; [
        droidcam-obs
      ];
    };

    #dconf.enable = true;

  };

  services = {
    ## dont think i NEED this tbh
    libinput.enable = true;
    ## Virtual filesystem, needed this for something i think ?
    gvfs.enable = true;
    ## Dbus is for ... 
    dbus.enable = true;
    ## no clue
    upower.enable = true;
    ## for managing disks
    udisks2.enable = true;
    ## dont think this works
    power-profiles-daemon.enable = true;
    ## ideally we're getting rid of most of this
    ## half of it doesn't even work lol
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
