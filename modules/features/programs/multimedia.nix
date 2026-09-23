{ inputs, ... }:

{

  # general multimedia module declaration
  flake.nixosModules.multimedia =

    { inputs, pkgs, ... }:

    {

      # for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      networking.firewall = {
        allowedTCPPorts = [
          # fileshare
          2234 # nicotine/soulseek
          8384 # syncthing
          8096 # jellyfin http
          8920 # jellyfin https
        ];
        allowedUDPPorts = [
          # fileshare
          2234 # nicotine/soulseek
          8384 # syncthing
          7359 # jellyfin client discovery
        ];
      };

      home-manager.users.sernity = {

        # alternative youtube frontend
        programs.freetube = {
          enable = true;
          settings.defaultQuality = "1080";
        };

        # other multimedia programs
        home.packages = with pkgs; [

          #browsing and fileshare
          transmission_4-gtk # torrent client
          nicotine-plus # p2p media sharing
          carburetor # gui for tor proxying
          chromium # google browser
          #lagrange # gemini network browser
          tractor # cli for tor proxying
          tor # the onion router

          # messaging and social
          vesktop

          # images
          gimp # general image editing
          #inkscape # vector image editing

          # video
          vlc # video player
          #shotcut # video editor

          # 3d creative
          blender # 3d modelling software
          orca-slicer # 3d printer slicer

        ];
      };

    };

}
