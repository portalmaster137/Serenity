{ inputs, outputs, lib, config, pkgs, ... }:

{
  ## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  ## find a better home for these please <3
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
  ## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

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
  };

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
  
    ## temporary/desktop
    waybar
    # gnome.gnome-keyring
    
    ## filsesystem
    ntfs3g
    xfsprogs
    udiskie
    gparted
  	
    ## tools
    fd
    bc
    tldr
    wget
    curl
    file
    zip
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

    ## nixos
    # nix-tree
    # nix-init
    # nix-index
    # nixpkgs-review
    # nix-output-monitor
 	
    ## languages and libraries
    rustup
    python313
 ];

}
