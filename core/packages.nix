{ inputs, outputs, lib, config, pkgs, ... }:

{

  imports = [
   #./file.nix
  ];

  nixpkgs = {

    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
      ];
    };

  ## [START - Stolen code, no clue how it works]
    overlays = [
      ## to use overlays exported from other flakes:
      #neovim-nightly-overlay.overlays.default

      ## or define it inline, for example:
      #(final: prev: {
        #hi = final.hello.overrideAttrs (oldAttrs: {
          #patches = [ ./change-hello-to-hi.patch ];
        #});
      #})
    ];

  };

  ## This will add each flake input as a registry
  ## To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);
  ## This will additionally add your inputs to the system's legacy channels
  ## Making legacy nix commands consistent as well, awesome!
  nix.nixPath = ["/etc/nix/path"]; 
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;
  ## [END - Stolen code, mostly understand from here again]


  ## I put fonts here because i didn't know where tf else to put them lol
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
          serif = [ "spleen-32x64" ];
          sansSerif = [ "spleen-32x64" ];        
          monospace = [ "TerminusTTF" ];
        };
      };
  };

  programs = {
   
    ## a catgirl's favourite shell
    fish = {
      enable = true;
    };

    ## for when bimbo needs to manage platters
    gnome-disks = {
      enable = true;
    };
    
    ## for handling encryption keys
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      #pinentryPackage = [ ];
    };
    ## i wanted this in the user-level area, but w/e i guess
    steam = {
      enable = true;
    };
    
    ## temporary, fuck vax-bingus or w/e his name is
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    
  };

  ## GNOME virtual file system, needed this for something i think ?
  services.gvfs.enable = true;

  ## xserver still needed for xwayland stuff
  services.xserver.enable = true;

  ## login greeter/display manager
  ## set to run on wayland also
  services.displayManager.sddm = {
  	enable = true;
  	wayland.enable = true;
  };

  ## i use micro btw (neovim scares me)
  environment.variables = {
    EDITOR = "micro";
    SYSTEMD_EDITOR = "micro";
    VISUAL = "micro";
  };

  ## enabling flatpak in case i need it
  services.flatpak.enable = true;

  ## all system-level packages declared here
  environment.systemPackages = with pkgs; [

    ## temporary desktop/user-level
    #waybar
    udiskie
    gparted
    pavucontrol
    networkmanager
    seahorse
    #polkit-gnome
    gnome-keyring
    polkit-kde-agent
    xorg.xhost

    ## nix specific tools
    #nix-tree
    #nix-init
    #nix-index
    #nixpkgs-review
    #nix-output-monitor

    ## filsesystem utilities
    zfs
    xfsprogs
    ddrutility
    exfatprogs
    btrfs-progs
    ntfs3g
    ntfs2btrfs
    scrounge-ntfs
    
    ## cli tools & utilities
    fd
    bc
    zip
    tldr
    wget
    curl
    file
    tree
    btop
    micro
    unzip
    gnupg
    s-tui
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
    undervolt
    #gitwatch

 ];

}
