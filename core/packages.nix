{ inputs, outputs, lib, config, pkgs, ... }:

{

  imports = [
   ./fonts.nix
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

  programs = {
    git.enable = true;
    fish.enable = true;
    gnome-disks.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = [ "pkgs.pinentry-curses" ];
    };
  };

  services.gvfs.enable = true;
  services.flatpak.enable = true;
  environment.systemPackages = with pkgs; [
  
    ## filsesystems
    zfs
    ntfs3g
    xfsprogs
    exfatprogs
    btrfs-progs
    ntfs2btrfs
    udiskie
    gparted
    
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
    pavucontrol

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
    # gnome.gnome-keyring
    
 ];

}
