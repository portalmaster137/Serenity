{ ... }:

{

  imports = [
    # ./file.nix
  ];

  networking = {
    wireless.enable = false;
    nameservers = [ "127.0.0.1" "::1" ];
    networkmanager = {
      enable = true;
      dns = "none";
    };

    #nameservers = [ 
      #"1.1.1.1" 
    #];

    #proxy = {
      #default = "https://user:password@proxy:port/";
      #noProxy = "127.0.0.1, localhost, internal.domain";
    #};
  
  };

  ## i knooooowwwwwww i need a proper firewall config but im laaaazzyyyyyyyyyy
  networking.firewall = {
    enable = true;
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

  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      ipv6_servers = true;
      require_dnssec = true;

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };

      # You can choose a specific set of servers from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
      server_names = [
        "adfilter-syd"
        "adfilter-syd-ipv6"
        "cs-sydney"
        "cs-singapore"
        "userspace-australia"
        "userspace-australia-ipv6"
      ];
    };
  };

  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };

  ## syncthing for device <-> device filesharing and,,, syncing
  ## still not set up, grrrr
  services.syncthing = {
    enable = false;
    user = "serenity";
    dataDir = "/home/serenity/sync/";
    configDir = "/home/serenity/flakes/nixdots/home/common/dotconfig/syncthing/";
     #overrideDevices = true;
     #overrideFolder = true;
   
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
