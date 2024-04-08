{ pkgs, ... }:

{

  programs = {
    # hyprland.enable = true;
  	traceroute.enable = true;
  	starship.enable = true;
  	fish.enable = true;
  	git.enable = true;

  	firefox.enable = true;
  	
  };

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

    ## compositor
  	waybar
  	swww
  	
  	## terminal
  	kitty
  	micro
  	pipes
    cbonsai
  	hyfetch
    cmatrix
    peaclock
    
  	## tools
  	file
  	fd
  	bc
  	gcc
  	zip
  	tldr
  	wget
  	curl
  	unzip
  	gnupg
  	blueman
  	busybox
  	ripgrep
  	killall
  	usbutils
  	pciutils
  	xdg_utils
  	moreutils
  	libsecret
  	git-crypt

  	## web browsers
  	# tor-browser-bundle-bin
  	# lagrange
  	# firefox

  	## misc, libraries, maybe more,
  	# qt5-wayland
  	# qt6-wayland
  	glib

  ];

  fonts = {

    packages = with pkgs; [
  	  spleen
  	  terminus_font
  	  terminus_font_ttf
  	  (nerdfonts.override { fonts = ["NerdFontsSymbolsOnly"]; })  	  
  	];

    fontDir.enable = true;

	fontconfig = {
	  defaultFonts = {

	  	monospace = [
	  	  "TerminusTTF"
	  	];
        serif = [
          "spleen-32x64"
        ];
        sansSerif = [
          "spleen-32x64"
        ];        

	  };
	};

  };

}
