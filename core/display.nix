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

  qt.style = "adwaita-dark";

}
