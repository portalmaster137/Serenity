{ pkgs, lib, config, ... }:

{

  imports = [
  ];


  services = {
  
    gvfs.enable = true;
    dbus.enable = true;
	
    avahi = {
      enable = false;
      nssmdns4 = false;
      openFirewall = false;
    };

    locate = {
      enable = false;
      package = pkgs.plocate;
      localuser = null;
    };

  };


  # disable these cuz they cause problems
  # see: https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services = {
  	networkManager-wait-online.enable = lib.mkForce false;
  	systemd-networkd-wait-online.enable = lib.mkForce false;
  };


  system.stateVersion = "23.11";

}
