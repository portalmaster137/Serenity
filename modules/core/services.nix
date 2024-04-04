{ pkgs, lib, config, ... }:

{

  imports = [
  ];


  services = {

    openssh = {
      enable = false;
    };
	
    avahi = {
      enable = false;
      nssmdns = false;
      openFirewall = false;
    };

    locate = {
      enable = false;
      package = pkgs.plocate;
      localuser = null;
    };

  };
  
  systemd.services = {
  	networkManager-wait-online.enable = lib.mkForce false;
  	systemd-networkd-wait-online.enable = lib.mkForce false;
  };


  system.stateVersion = "23.11";

}
