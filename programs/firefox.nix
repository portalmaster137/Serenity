pkgs: {
  enable = true;
  profiles = {
    nixos = {
      name = "NixOS Profile";
      settings = {
        "media.ffmpeg.vaapi.enabled" = true;
        "browser.startup.homepage" = "https://sashanoraa.gay/";
        "browser.cache.disk.capacity" = 536870912; # 1 GiB
        "extensions.pocket.enabled" = false;
        "browser.eme.ui.enabled" = false; # DRM popup
        "image.jxl.enabled" = true;
        "browser.aboutConfig.showWarning" = false;
        "browser.search.suggest.enabled" = false;
      };
      search.force = true;
      search.default = "NixOS Wiki";
      search.engines = {
        "YouTube" = {
          urls = [{
            template = "https://youtube.com/results";
            params = [
              { name = "search_query"; value = "{searchTerms}"; }
              { name = "page"; value = "{startPage}"; }
            ];
          }];
          iconUpdateURL = "https://www.youtube.com/favicon.ico";
          updateInterval = 7 * 24 * 60 * 60 * 1000; # every week
          definedAliases = [ "!yt" ];
        };
        "ArchWiki" = {
          urls = [{
            template = "https://wiki.archlinux.org/index.php";
            params = [
              { name = "search"; value = "{searchTerms}"; }
              { name = "title"; value = "Special:Search"; }
            ];
          }];
          iconUpdateURL = "https://wiki.archlinux.org/favicon.ico";
          updateInterval = 7 * 24 * 60 * 60 * 1000; # every week
          definedAliases = [ "!a" ];
        };
        "NixOS Wiki" = {
          urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
          iconUpdateURL = "https://nixos.wiki/favicon.png";
          updateInterval = 7 * 24 * 60 * 60 * 1000; # every week
          definedAliases = [ "!nix" ];
        };
        "GitHub" = {
          urls = [
            {
              template = "https://github.com/search";
              params = [
                { name = "q"; value = "{searchTerms}"; }
              ];
            }
          ];
          iconUpdateURL = "https://github.com/favicon.ico";
          updateInterval = 7 * 24 * 60 * 60 * 1000; # every week
          definedAliases = [ "!gh" ];
        };
        "Wikipedia (en)".metaData.alias = "!w";
        "Google".metaData.alias = "!g";
      };
    };
  };
}
