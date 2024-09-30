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
  ## CURRENTLY BROKEN - PLEASE FIX
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

  hardware.opentabletdriver = {
    enable = true;
     #package = [ ];
     #daemon.enable = true;
     #blacklistedKernelModules = [ ];
  };

  programs = {

    ## NixOS CLI helper
    nh = {
      enable = true;
      flake = "/home/serenity/flakes/nixdots";
    };

    ## A catgirl's favourite shell
    fish = {
      enable = true;
    };

    ## For when bimbo needs to play with platters
    gnome-disks = {
      enable = true;
    };
    
    ## For handling encryption keys
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      #pinentryPackage = [ ];
    };
    ## I wanted this in the user-level area, but w/e i guess
    steam = {
      enable = true;
    };

    ## Temporary, fuck vaxery or whatever his name is
    ## punk-ass motherfucker, swayfx looks neat
    ## and is probably more stable anyway so yeah
    ## whatever, im not mad, why would you think im mad
    ## its not like the prettiest wayland "wm" has
    ## a complete shithead as a lead dev, it's not
    ## like i got sold on it and nearly set it up
    ## completely before finding out about vaxo-bingus'
    ## chuddery and deciding i had to jump ship to sway
    ## a "wm" with comparatively little by ways of 
    ## "eye-candy". Oh boy am i glad swayfx exists
    ## 
    ## Authors note: this is excessive, overly dramatic,
    ## and played entirely (mostly) for laughs.
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

  ## We switched to neovim -mostly- full-time
  environment.variables = {
    EDITOR = "neovim";
    SYSTEMD_EDITOR = "neovim";
    VISUAL = "neovim";
  };

  ## Enabling flatpak in case i need it
  services.flatpak.enable = true;

  ## All* system-level packages declared here
  environment.systemPackages = with pkgs; [

    ## Needed for that graphical config manager, suspect that the
    ## whole inputs.nix- yaddah yaddah is unnecessary.
    ## and look, -we- don't need a graphical config editor, but
    ## the end goal here is to make a system environment that could
    ## theoretically pass off as a complete linux distribution.
    ## So there needs to be -some- way for users who are unwilling
    ## to use a terminal and are more comfortable with a GUI.
    inputs.nixos-conf-editor.packages.${system}.nixos-conf-editor
     #nixos-conf-editor

    ## Temporary desktop/user-level
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

    ## Jellyfin for home media share
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg

    ## Nix specific tools
    #nix-tree
    #nix-init
    #nix-index
    #nixpkgs-review
    #nix-output-monitor

    ## Filsesystem utilities
    xfsprogs
    ddrutility
    exfatprogs
    btrfs-progs
    ntfs3g
    ntfs2btrfs
    scrounge-ntfs
    
    ## CLI tools & utilities
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
    steam
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
