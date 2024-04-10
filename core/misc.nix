{ inputs, outputs, lib, config, pkgs, ... }:

{

  programs.hyprland = {
  	enable = true;
  	xwayland.enable = true;
  };

  services.xserver = {
    enable = true;
    displayManager.sddm = {
  	  enable = true;
  	  wayland.enable = true;
    };
  };

  services.gnome = {
  	gnome-keyring.enable = true;
  };

  qt.style = "adwaita-dark";

  ## apparently prevents getting stuck at shutdown
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";

}
