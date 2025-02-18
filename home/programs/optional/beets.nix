{ pkgs, ... }:

{

  programs = {
    beets = {
      enable = true;
      #mpdIntegration = { };
      #settings = { };
    };
  };

}
