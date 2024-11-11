{ inputs, outputs, lib, config, pkgs, ... }:

{

  imports = [
     #./file.nix
    ./fonts.nix
  ];

  nixpkgs = {

    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
      ];
       #allowUnsupportedSystem = true;
    };

  ## [START - Stolen code, no clue how it works :3 ]
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

  hardware.opentabletdriver = {
    enable = true;
     #package = [ ];
     #daemon.enable = true;
     #blacklistedKernelModules = [ ];
  };

  environment.sessionVariables = rec {
	  XDG_CACHE_HOME  = "$HOME/.cache";
	  XDG_CONFIG_HOME = "$HOME/.config";
	  XDG_BIN_HOME    = "$HOME/.local/bin";
	  XDG_DATA_HOME   = "$HOME/.local/share";
	  # Steam needs this to find Proton-GE
	  STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
	  # note: this doesn't replace PATH, it just adds this to it
	  PATH = [ 
	    "\${XDG_BIN_HOME}"
	  ];
  };

  programs = {

    ## For when bimbo needs to play with platters and cbf to deal with cli
    gnome-disks.enable = true;

    ## A catgirl's favourite shell - NEEDS OWN NIX MODULE
    fish = {
      enable = true;
    };

    ## I wanted this in the user-level area, but w/e i guess - NEEDS OWN NIX MODULE
    steam = {
      enable = true;
    };

    ## To run "normal" linux applications seamlessly - OWN NIX MODULE ?
    appimage = {
      enable = true;
      binfmt = true;
    };

    ## NixOS CLI helper
    nh = {
      enable = true;
      flake = "/home/serenity/flakes/nixdots";
    };

    ## For handling encryption keys
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      #pinentryPackage = [ ];
    };

  };

  ## GNOME stuff
  services.gvfs.enable = true; # Virtual filesystem, needed this for something i think ?
  services.gnome.gnome-keyring.enable = true; # maybe this fixey keyring OwO ?
  services.gnome.gnome-settings-daemon.enable = true; # GUI settings ?
  security.pam.services.serenity.enableGnomeKeyring = true; # dunno if i did this right, but possible needed for keyring/polkit stuff ?

  ## Wei have switched to neovim
  ## full-time, sorry Micro. <3
  environment.variables = {
    EDITOR = "neovim";
    VISUAL = "neovim";
    SYSTEMD_EDITOR = "neovim";
  };

  ## Enabling flatpak in case i need it
   #services.flatpak.enable = true;

  ## ratbagd for gaming mouse config
  services.ratbagd.enable = true;

  ## All COMMON system-level packages declared here
  environment.systemPackages = with pkgs; [

    ########
    ## Needed for that graphical config manager, suspect that the
    ## whole inputs.nix- yaddah yaddah is unnecessary.
    ## and look, -we- don't need a graphical config editor, but
    ## the end goal here is to make a system environment that could
    ## theoretically pass off as a complete linux distribution.
    ## So there needs to be -some- way for users who are unwilling
    ## to use a terminal and are more comfortable with a GUI.

     #inputs.nixos-conf-editor.packages.${system}.nixos-conf-editor
     #nixos-conf-editor

    ## Disabling this for now. Eats disk space, and it's useless until
    ## wei make a single "control" module using 'let bindings' anyway.
    ########



    ########
    ## Temporary desktop/user-level
    steam
     #gitwatch
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
    android-tools
    ########


    ########
    ## Jellyfin for home media share
    ## Need to move this to its own module and call that to
    ## save the 'core' from being bloated.
     #jellyfin
     #jellyfin-web
     #jellyfin-ffmpeg
    ########

    ## Nix specific tools
    nix-tree
     #nix-init
     #nix-index
     #nixpkgs-review
    nix-output-monitor

    ## Filsesystem utilities
    xfsprogs
    ddrutility
    exfatprogs
    btrfs-progs
    ntfs3g
     #ntfs2btrfs
    scrounge-ntfs
    
    ## CLI tools & utilities
    fd
    bc
    zip
    tldr
    wget
    curl
    bash
    file
    tree
     #btop
     #micro
    unzip
    gnupg
    s-tui
    blueman
    busybox
    ripgrep
    killall
    usbutils
    pciutils
    xdg-utils
    moreutils
    libsecret
    git-crypt
    undervolt
    magic-wormhole

 ];

}
