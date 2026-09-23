{ self, inputs, ... }:

{

  # network proxy module declaration
  flake.nixosModules.netproxy =

    {
      inputs,
      ...
    }:

    {

      # encrypts your dns requests to aid in online privacy
      services.dnscrypt-proxy = {
        enable = true;
        settings = {
          ipv6_servers = true;
          require_dnssec = true;
          sources.public-resolver = {

            # cache and keyfile for verification
            cache_file = "var/lib/dnscrypt-proxy2/public-resolvers.md";
            minisign_key = "";

            # urls to get resolver addresses from
            urls = [
              "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
              "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
            ];

          };

          # dns resolver addresses to use
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

      # tor/socks ?

    };
}
