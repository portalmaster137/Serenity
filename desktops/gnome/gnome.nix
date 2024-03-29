{ inputs, outputs, config, pkgs, lib, osConfig, ... }:

{
 
  imports = [
  # <home-manager/nixos>
  ];

  services = {
  
    xserver = {
      displayManager.gdm.enable = true;
  	  desktopManager.gnome.enable = true;
    };
    
    gnome = {
      # gnome-keying.enable = true;
      # gnome-online-accounts.enable = false;
    };

    udev.packages = with pkgs; [
      gnome.gnome-settings-daemon
    ];
  };

  # qt = {
    # style = "adwaita-dark";
  };

  programs = {
    # home-manager.enable = true;
    dconf.enable = true;
  };

  environment = { 
  	systemPackages = with pkgs; [
  	  helvum
  	  fragments
  	  gnome-photos
  	  gnome-secrets
  	  gnome-decoder
  	  authenticator
  	  gnome-extension-manager
  	] ++ (with pkgs.gnome; with pkgs.gnomeExtensions; [
  	  pano
  	  sushi
  	  gnome-boxes
  	  gnome-tweaks
  	  dconf-editor
  	  nautilus-python
 #  shell extensions
  	  ddterm
  	  caffeine
  	  gsconnect
  	  dash-to-panel
  	  just-perfection
  	  clipboard-indicator
  	  custom-accent-colors
  	  quick-settings-tweaker
  	  rounded-window-corners
  	]) ++ (with pkgs.unstable; [
  	  mission-center
  	  fractal
  	]);
  	# ]) ++ (import ./pkg-scripts pkgs);
  	
  	gnome.excludePackages = (with pkgs; with pkgs.gnome; [
  	  snapshot
  	  gnome-tour
  	  gnome-usage
  	  # gnome-text-editor
  	  gnome-connections
  	  
  	  yelp
  	  geary
  	  # gedit
  	  cheese
  	  epiphany
  	  gnome-maps
  	  simple-scan
  	  gnome-clocks
  	  gnome-weather
  	  gnome-terminal
  	  gnome-software
  	  gnome-contacts
  	  gnome-calendar
  	  gnome-initial-setup
  	  gnome-system-monitor
  	  
  	]);
  	
  };

}
