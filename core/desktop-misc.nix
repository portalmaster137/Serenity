{ self, inputs, outputs, lib, config, pkgs, ... }:

{

  imports = [
  ];

  programs = {

    ## For when bimbo needs to play with platters and cbf to deal with cli
    gnome-disks.enable = true;
    ## GTK secrets management
    seahorse.enable = true;
    ## Use android device as a webcam
    droidcam.enable = true;
    ## Apparently nm-applet has a programs option
    nm-applet = {
      enable = true;
      indicator = false;
    };
    ## idk something for nautilus
    nautilus-open-any-terminal = {
      enable = true;
      terminal = "kitty";
    };

    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = with pkgs.obs-studio-plugins; [
        droidcam-obs
      ];
    };

  };

  environment.systemPackages = with pkgs; [
  ];

}
