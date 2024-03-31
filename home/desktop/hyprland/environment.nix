{ config, pkgs, ... }:

{ 

  home = {

	sessionVariables = {
	  EDITOR = "micro";
	  BROWSER = "firefox";
	  TERMINAL = "kitty";

	  XDG_CURRENT_DESKTOP = "Hyprland";
	  XDG_SESSION_DESKTOP - "Hyprland";
	  XDG_SESSION_TYPE = "wayland";
	  
	};
  	
  };

}
