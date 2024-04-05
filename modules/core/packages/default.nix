{pkgs, config, inputs, ... }:

{

  imports = [
  	./packages.nix
  ];


  services.flatpak.enable = true;

  qt.style = "adwaita-dark";
  
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
    # gc = {
      # automatic = true;
    # };
  };
  
  nixpkgs = {
    overlays = [
   	  # self.overlays.default
      # inputs.nur.overlay
    ];
    config = {
   	  allowUnfree = true;
   	  permittedInsecurePackages = [
   	  	"schildichat-web-1.11.30-sc.2"
   	  	"electron-25.9.0"
   	  	# "nix-2.15.3"
   	  ];
    };
  };

  environment.variables  = {
  	NIXOS_OZONE_WL = "1";
  	NIXPKGS_ALLOW_UNFREE = "1";
  	PATH = [
  	  "\${HOME}/.local/bin"
  	  "\${HOME}/.config/rofi/scripts"
  	];
  };

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
