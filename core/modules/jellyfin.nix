{ inputs, outputs, lib, config, pkgs, ... }:

{

  imports = [ ];

  programs = { };

  environment.systemPackages = with pkgs; [
    ## Jellyfin for home media share
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];

}
