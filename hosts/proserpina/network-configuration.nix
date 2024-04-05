{ pkgs, lib, config, ... }:

{

  imports = [
  	# ./file.nix
  ];

  networking = {
    hostName = "proserpina";
  	wireless.enable = false;
  	networkmanager = {
  	  enable = true;
  	};
  	# nameservers = [ 
  	# "1.1.1.1" 
  	# ];
  };

  # networking.proxy = {
  	# default = "https://user:password@proxy:port/";
  	# noProxy = "127.0.0.1, localhost, internal.comain";
  # };

  networking.firewall = {
  	enable = false;
  	# checkReversePath = "loose";
  	# allowedTCPPorts = [ 22000 21027 25565 ];
  	# allowedUDPPorts = [ 22000 21027 41641 51820 ];
  	# allowedTCPPortRanges = [
  	  # { from = 9999; to = 9999; } # KDE COnnect
  	  # { from = 9999; to = 9999; } # Nicotine+
  	# ];
  	# allowedUDPPortRanges = [
  	  # { from = 9999; to = 9999; } # KDE COnnect
  	# ];
  	# interfaces."DEVICENAME".allowedTCPPorts = [ 22999 ]
  };

  services.syncthing = {
    enable = false;
    dataDir = "/home/serenity/";
    configDir = "/home/serenity/.config/syncthing";
    user = "serenity";
    settings.devices = {
    
      # hades.id = "DEVICE_ID";
      # proserpina.id = "DEVICE_ID";
      # hecate.id = "DEVICE_ID";
      
    };    
    settings.folders = {

        # "FOLDER_ID" = {
      	  # path = "/home/serenity/Documents/Notes";
      	  # devices = [ "hecate" "hades" "proserpina" ];
      	# };

        # "FOLDER_ID" = {
      	  # path = "/home/serenity/Documents/Notes";
      	  # devices = [ "hecate" "hades" "proserpina" ];
      	# };
      	
        # "FOLDER_ID" = {
      	  # path = "/home/serenity/Documents/Notes";
      	  # devices = [ "hecate" "hades" "proserpina" ];
      	# };
      	
    };   	
  };
	
}
