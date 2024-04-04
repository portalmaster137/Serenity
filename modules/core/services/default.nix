{ pkgs, lib, config, ... }:

{

  imports = [
  	# file.nix
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
  

}
