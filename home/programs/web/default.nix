{ pkgs, ... }:

{

  imports = [ ];

  home = {
    packages = with pkgs; [
      transmission_4-gtk # Torrent client
      nicotine-plus # P2P Media sharing
      carburetor # GUI settings for tractor
      jellyfin # Self-hosted media streaming
      syncplay # Synchronise media playback
      lagrange # GUI Gemini browser
      tractor # TOR network routing
      tor # The Onion Router
    ];
  };

  programs = {
    firefox = { # Web browser of choice
      enable = true;
    };
  };

}
