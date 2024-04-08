{pkgs, config, inputs, ... }:

{

  imports = [
  	./packages.nix
  ];

  
  nix = {
    settings = {
      cores = 0;
   	  auto-optimise-store = true;
   	  allowed-users = [
   	  	"@wheel"
   	  ];
      experimental-features = [ 
      "nix-command"
      "flakes"
      ];  	
    };
  };
  
  nixpkgs = {
    overlays = [
    ];
    config = {
   	  allowUnfree = true;
   	  permittedInsecurePackages = [
   	  	"schildichat-web-1.11.30-sc.2"
   	  	"electron-25.9.0"
   	  ];
    };
  };


  qt.style = "adwaita-dark";

  services.flatpak.enable = true;

  boot.binfmt.registrations.appimage = {
  	wrapInterpreterInShell = false;
  	interpreter = "${pkgs.appimage-run}/bin/appimage-run";
  	recognitionType = "magic";
  	offset = 0;
  	mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
  	magicOrExtension = ''\x7fELF....AI\x02'';
  };


  system = {
    stateVersion = "23.11";
  	# autoUpgrade = {
  		# enable = true;
  		# channel = "INSERT_CHANNEL";
  	# };
  };

}
