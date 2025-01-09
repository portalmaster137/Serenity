{ pkgs, ... }:

{

  imports = [
    #./syncthing 
  ];

  home = {
    packages = with pkgs; [
      transmission_4-gtk # Torrent client
      nicotine-plus # P2P Media sharing
      jellyfin # Self-hosted media streaming
      syncplay # Synchronise media playback
      lagrange-tui # TUI Gemini browser
      lagrange # GUI Gemini browser
      tor # The Onion Router
    ];

    programs = {
      firefox = { # Web browser of choice
        enable = true;
      };
    };
  };

}
