{ inputs, outputs, lib, config, pkgs, ... }:

{

  imports = [
   #./file.nix
  ];

  nixpkgs = {

    ## configure nixpkgs instance
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
      ];
    };

    ## add overlays here
    overlays = [
      ## to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      ## or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
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
  
    git.enable = true;
    fish.enable = true;
    gnome-disks.enable = true;
    
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      #pinentryPackage = [ ];
    };
    
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    
  };

  services.gvfs.enable = true;
  
  services.xserver = {
    enable = true;
    displayManager.sddm = {
  	  enable = true;
  	  wayland.enable = true;
    };
  };
  
  services.flatpak.enable = true;
  
  environment.systemPackages = with pkgs; [
  
    ## filsesystems
    zfs
    ntfs3g
    xfsprogs
    exfatprogs
    btrfs-progs
    ntfs2btrfs
    
    ## tools
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

    ## nixos
    nix-tree
    #nix-init
    #nix-index
    #nixpkgs-review
    #nix-output-monitor
 	
    ## languages and libraries
    #rustup
    #python313

    ## temporary/desktop
    waybar
    udiskie
    gparted
    pavucontrol
    #polkit-gnome
    gnome.seahorse
    polkit-kde-agent
    gnome.gnome-keyring
    
 ];

}
