{ pkgs, lib, ... }:
{

  imports = [
    # ./packages
    # ./packages.nix
    ./users.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-25.9.0"
      "nix-2.15.3"
    ];
  };

  # nix options
  nix = {
    settings = {
      cores = 0;
      auto-optimise-store = true;
      allowed-users = [ "@wheel" ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  # cleanup packages older than 3 days from nix store
    gc = {
      # automatic = true;
      # dates = "weekly";
      # options = "--delete-older-than 5d";
      # persistent = true;
    };
  };
  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 5;
      efi.canTouchEfiVariables = true;
    };
    # plymouth.enable = true;
    initrd = {
      systemd.enable = true;
      secrets = {
        "/crypto_keyfile.bin" = null;
      };
      # kernelParams = [
  	# "quiet"
      # ];
      # kernel.sysctl = {
        # "kernel.sysrq" = 1;
      # };
      luks = {
        # devices."luks-uuid" = {
  	  # device = "/dev/disk/by-uuid/luks-uuid";
        # };
      };
    };
  };

  # Run appimages normally
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };

 security = {
   sudo.execWheelOnly = true;
 };

  # Enable networking
  networking = {
  	wireless.enable = false;
  	networkmanager = {
  	  enable = true;
  	  insertNameServers = [
  	  	# "10.7.0.1"
  	  ];
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

  # Enable X11 & GNOME
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
    # nix-output-monitor
    # nixpkgs-review
    appimage-run
    # nix-index
    # nix-tree
    # nix-init   
 # essentials
    # firefox
    lagrange
    tor-browser-bundle-bin
 # misc/Fonts
    font-manager
    (unstable.nerdfonts.override { fonts = ["NerdFontsSymbolsOnly"]; })
 # cli
    file
    zip
    unzip
    busybox
    killall
    usbutils
    pciutils
    moreutils
    
    libsecret
    git-crypt
    gnupg

    micro
    ffmpeg
    ventoy
    hyfetch
    
 # languages

 #  - python
    # python313

 #  - javascript/typescript

 #  - dart/flutter

 #  - golang

 # - c/++/#

 #  - rust
    # rustc
    # rustup
    # cargo-edit
    # cargo-outdated
    # cargo-update
    # cargo-auditable
    # cargo-audit
    # cargo-cross
    # cargo-bloat
    # cargo-msrv    
  ];

  # Qt dark mode
  # qt.style = "adwaita-dark";

  # More programs I want
  programs = {
    # home-manager.enable = true;
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
  # List services that you want to enable:

  services = {
  
    flatpak.enable = true;
  
    udev.packages = with pkgs; [
      # yubikey-personalization
    ];
    locate = {
      enable = false;
      package = pkgs.plocate;
      localuser = null;
    };
    printing = {
      enable = false;
      # drivers = with pkgs; [ gutenprint hll2390dw-cups ];
    };
    avahi = {
      enable = false;
      nssmdns = false;
      openFirewall = false;
    };
    openssh = {
      enable = false;
    };
    
  };

  # Set up hardware acceleration
  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  hardware = {
    # MOVED
  };

  # Disable these cuz they cause problems. see: https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services = {
  	NetworkManager-wait-online.enable = lib.mkforce false;
  	systemd-networkd-wait-online.enable = lib.mkforce false;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
  
}
