{ ... }:

{

  networking = {
    wireless.enable = false;
    nameservers = [ "127.0.0.1" "::1" ];
    networkmanager = {
      enable = true;
      dns = "none"; # handled by dnscrypt
    };
  };

  ## Rudimentary firewall config
  networking.firewall = {
    enable = true;

    ## Specific TCP ports to be opened
    allowedTCPPorts = [
      2234 # soulseek/nicotine-plus
      8384 # syncthing
    ];

    ## Specific UDP ports to be opened
    allowedUDPPorts = [
      2234 # soulseek/nicotine-plus
      8834 # syncthing
    ];

    ## Ranges for TCP and UDP ports to be opened
    ## - disabled for now as network infrastructure is minimal
    #allowedTCPPortRanges = [ { from = 1720; to = 1770; } ];
    #allowedUDPPortRanges = allowedTCPPortRanges;

  };

  ## Systemd service for the dnscrypt config declared below
  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };

  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      ipv6_servers = true;
      require_dnssec = true;
      sources.public-resolvers = {
        ## Where to get list of server addresses
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        ## key and cachefile to verify servers and authenticity
        minisign_key =
          "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
      };

      ## Select a specific server, or a set of servers from the link below
      ## - https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
      server_names = [
        "cs-sydney"
        "cs-singapore"
        "mullvad-doh"
        "mullvad-adblock-doh"
        "adfilter-syd"
        "adfilter-syd-ipv6"
        "userspace-australia"
        "userspace-australia-ipv6"
      ];
    };
  };

}
