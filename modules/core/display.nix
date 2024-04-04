{ inputs, pkgs, username, ... }:

{ 

  programs.hyprland = {
  	enable = true;
  	xwayland.enable = true;
  };
  
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
  	layout = "us"; # what is the difference #
  	xkbVariant = ""; # between
  	xkb.layout = "us"; # these 2 lolwut #
  	displayManager.autoLogin = {
  	  enable = true;
  	  user = "serenity";
  	};
  	libinput = {
  	  enable = true;
  	  mouse = {
  	  	accelProfile = "flat";
  	  };
  	};
  };

  # apparently prevents getting stuck at shutdown
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";

  # set up hardware video acceleration
  # https://nixos.wiki/wiki/Accelerated_Video_Playback

  system.stateVersion = "23.11";

}
