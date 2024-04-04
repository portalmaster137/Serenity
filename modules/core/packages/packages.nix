{ ... }:

{

  environment.systemPackages = with pkgs; [

  	## web browsers
  	tor-browser-bundle=bin
  	# lagrange
  	firefox

  	## filsesystem support
  	udiskie
  	ntfs3g
  	xfsprogs
  	
  	## nixos specific
  	# home-manager
  	appimage-run
  	# nix-tree
  	# nix-init
  	# nix-index
  	# nixpkgs-review
  	# nix-output-monitor
  	

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

  	## misc/fonts
  	(unstable.nerdfonts.override { fonts = ["NerdFontsSymbolsOnly"]; })

    ## maybe more

    ## libraries
    glib
    qt5-wayland
    qt6-wayland
  	
  ];


  programs = {
    # home-manager.enable = true;
  	traceroute.enable = true;
  	starship.enable = true;
  	corectrl.enable = true;
  	firefox.enable = true;
  	fish.enable = true;
  	# htop.enable = true;
  	git.enable = true;
  	gnupg.agent = {
  	  enable = false;
  	  enableSSHSupport = false;
  	};
  	
  };


}
