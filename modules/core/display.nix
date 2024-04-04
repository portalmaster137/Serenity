{ inputs, pkgs, username, ... }:

{ 

  programs.hyprland.enable = true;
  xdg.portal = {
  	enable = true;
  	wlr.enable = true;
  	xdgOpenUsePortal = true;
  	extraPortals = [
  	  pkgs.xdg-desktop-portal-hyprland
  	  pkgs.xdg-desktop-portal-gtk
  	];
  };
  
  services.xserver = {
  	enable = true;
  	xkb.layout = "us";
  	displayManager.autoLogin = {
  	  enable = true;
  	  user = "${USERNAME}";
  	};
  	libinput = {
  	  enable = true;
  	  # mouse = {
  	  	# accelProfile = "flat";
  	  # };
  	};
  };

  # apparently prevents getting stuck at shutdown
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";

}
