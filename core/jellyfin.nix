{ inputs, outputs, lib, config, pkgs, primaryUser, ... }:

{

  imports = [ ];

  programs = { };

  environment.systemPackages = with pkgs; [
    ## Jellyfin for home media share
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];

  services = {
    jellyfin = {
      enable = true;
      openFirewall = true;
      user = "${primaryUser}";
    };
  };

  #nixpkgs.config.packageOverrides = pkgs: { # enable vaapi on OS-level
    #vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  #};

  #systemd.services.jellyfin.environment.LIBVA_DRIVER_NAME = "iHD"; # or i965, see below
  #environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; }; # ditto
  
  hardware.graphics = {
    #enable = true;
    extraPackages = with pkgs; [
      #intel-ocl # generic OpenCL support, for all processors
      # For newer processors (Broadwell and higher, ca. 2014), use this paired with `LIBVA_DRIVER_NAME=iHD`:
      #intel-media-driver
      # ... while for older processors, use these paired with `LIBVA_DRIVER_NAME=i965`:
      #intel-vaapi-driver 
      #libva-vdpau-driver # aka vaapiVdpau
      # In addition, for newer processors (13th gen and higher), add this as well:
      #intel-compute-runtime
      #  ... while for older processors, add this (https://github.com/NixOS/nixpkgs/issues/356535):
      #intel-compute-runtime-legacy1 
      # In addition once more, for newer processors (11th gen or newer), add this:
      #vpl-gpu-rt
      # ... while for older processors, add this:
      #intel-media-sdk # (note it's been deprecated since NixOS 25.11 and may not build anymore nowadays)
    ];
  };

}
