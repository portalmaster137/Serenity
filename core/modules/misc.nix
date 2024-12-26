{ pkgs, ... }:

{

  ## Dunno if i did this right, but possible needed for keyring/polkit stuff ? 
  security.pam.services.serenity.enableGnomeKeyring = true;

  programs = {
    gnome-disks.enable = true; # For when bimbo needs to manage disks
    seahorse.enable = true; # GTK secrets management
    droidcam.enable = true; # Use android device as a webcam
    obs-studio = { # screen capture, recording, and sharing
      enable = true;
      enableVirtualCamera = true; # virtual webcam
      plugins = with pkgs.obs-studio-plugins; [
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
