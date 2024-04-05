{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [

  	## nixos
  	appimage-run
  	# nix-tree
  	# nix-init
  	# nix-index
  	# nixpkgs-review
  	# nix-output-monitor

  	## filsesystem
  	udiskie
  	ntfs3g
  	xfsprogs
  	
  	## terminal
  	kitty
  	micro
  	
  	## cli tools
  	hyfetch
  	file
  	zip
  	unzip
  	gnupg
  	busybox
  	killall
  	usbutils
  	pciutils
  	moreutils
  	libsecret
  	git-crypt

  	## web browsers
  	# tor-browser-bundle-bin
  	# lagrange
  	# firefox

  	## misc, fonts, libraries, maybe more
  	(nerdfonts.override { fonts = ["NerdFontsSymbolsOnly"]; })
  	qt5-wayland
  	qt6-wayland
  	glib

  ];


  programs = {
  	traceroute.enable = true;
  	starship.enable = true;
  	fish.enable = true;
  	git.enable = true;

  	# firefox.enable = true;
  	
  };


}
