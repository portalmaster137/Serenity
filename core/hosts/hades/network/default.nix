{ pkgs, lib, config, ... }:

{

  imports = [
    # ./file.nix
  ];

  networking = {
    ## ooh, hostname - that one's important!
    hostName = "hades";
    wireless.enable = false;
    networkmanager = {
      enable = true;
    };

    #nameservers = [ 
      #"1.1.1.1" 
    #];

    #proxy = {
      #default = "https://user:password@proxy:port/";
      #noProxy = "127.0.0.1, localhost, internal.domain";
    #};
  
  };

  ## i knooooowwwwwww i need a firewall but im laaaazzyyyyyyyyyy
  networking.firewall = rec {
    enable = false;
       #checkReversePath = "loose";
       #allowedTCPPortRanges = [ { from = 1720; to = 1770; } ];
       #allowedUDPPortRanges = allowedTCPPortRanges;
       #interfaces."DEVICENAME".allowedTCPPorts = [
         #22999
       #]
       #allowedTCPPorts = [
         #22000
         #21027
         #25565
       #];
       #allowedUDPPorts = [
         #22000
         #21027
         #41641
         #51820
       #];
  };

  openFirewall = true;

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  ## syncthing for device <-> device filesharing and,,, syncing
  ## still not set up, grrrr
  services.syncthing = {
    enable = false;
    user = "serenity";
    dataDir = "/home/serenity/";
    configDir = "/home/serenity/flakes/nixdots/home/config/syncthing";
    overrideDevices = true;
    overrideFolder = true;
   
    ## these 3 devices are pretty much my entire ecosystem for now
    settings.devices = {
      #hades.id = "DEVICE_ID";
      #proserpina.id = "DEVICE_ID";
      #hecate.id = "DEVICE_ID";
    };

    ## plan to have this dir automatically committed and pushed to a git repo daily
    settings.folders = {
      #"FOLDER_ID" = {
        #path = "/home/serenity/Documents/Notes";
      	#devices = [ "hecate" "hades" "persephone" ];
      #};
      	
    };   	
  };
	
}
