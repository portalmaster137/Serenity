{ pkgs, lib, ... }:
{

  imports = [
  ];

 security = {
   sudo.execWheelOnly = true;
 };

  # Enable networking
  networking = {
  	wireless.enable = false;
  	networkmanager = {
  	  enable = true;
  	  # insertNameServers = [
  	  	# "10.7.0.1"
  	  # ];
  	};
  	proxy = {
  	  # default = "https://user:password@proxy:port/";
  	  # noProxy = "127.0.0.1, localhost,internal.domain";
  	};
    firewall = {
      enable = false;
      # allowedTCPPorts = [ 22000 21027 25565 ];
      # allowedUDPPorts = [ 41641 22000 21027 51820 ];
      # allowedTCPPortRanges = [
        # { from = 1714; to = 1764; } # KDE Connect
        # { from = 2234; to = 2239; } # Nicotine+
      # ];
      # allowedUDPPortRanges = [
        # { from = 1714; to = 1764; } # KDE Connect
      # ];
      # checkReversePath = "loose";
      # interfaces."tun0".allowedTCPPorts = [ 28996 ];
    };
  };

  # Set your time zone.
  time.timeZone = "Australia/Brisbane";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  # Enable X11
  services.xserver = {
  	enable = true;
  	# displayManager.gdm.enable = true;
  	# desktopManager.gnome.enable = true;
  	layout = "us";
  	xkbVariant = "";
  };

  # Enable sound with pipewire.
  # sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    # Use the example session manager (this is enabled by default)
    # media-session.enable = true;
  };


  environment.systemPackages = with pkgs; [
  
 # file system support
    ntfs3g
    xfsprogs
    
 # nixos specific
    appimage-run
    # home-manager
    # nix-output-monitor
    # nixpkgs-review
    # nix-index
    # nix-tree
    # nix-init  
     
 # web browsers
    firefox
    # lagrange
    tor-browser-bundle-bin
    
 # misc/Fonts
    (unstable.nerdfonts.override { fonts = ["NerdFontsSymbolsOnly"]; })

 # terminal stuff
	kitty
	micro
	hyfetch
    
 # cli utilities
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
  
  ];

  # Qt dark mode
  # qt.style = "adwaita-dark";

  # More programs I want
  programs = {
    # home-manager.enable = true;
    # hyprland = {
      # enable = true;
      # xwayland.enable = true;
    # };
    traceroute.enable = true;
    corectrl.enable = true;
    firefox.enable = true;
    htop.enable = true;
    git.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = false;
    };
    fish = {
      enable = true;
      # import programs/fish.nix pkgs;
    };
    
    # starship.enable = true;
    
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.

  # Set up hardware acceleration
  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  hardware = {
  };

  # Disable these cuz they cause problems. see: https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services = {
  	NetworkManager-wait-online.enable = lib.mkForce false;
  	systemd-networkd-wait-online.enable = lib.mkForce false;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
  
}
