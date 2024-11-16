{ inputs, outputs, lib, config, pkgs, ... }:

{

  imports = [
     #./file.nix
  ];

  nixpkgs = {

    config = {
      allowUnfree = true;
      ## Place insecure packages here
      permittedInsecurePackages = [
      ];
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

  programs = {

    ## A catgirl's favourite shell - NEEDS OWN NIX MODULE
    fish = {
      enable = true;
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

  ## Wei have switched to neovim
  ## full-time, sorry Micro. <3
  environment.variables = {
    EDITOR = "neovim";
    VISUAL = "neovim";
    SYSTEMD_EDITOR = "neovim";
  };

  ## Install a stub ELF loader to print an informative
  ## error message in the event that a user attempts
  ## to run an ELF binary not compiled for NixOS.
  environment.stub-ld.enable = true;

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

    ## Nix specific tools
    nix-tree # Dependency tree viewer for nix store
     #nix-init # Generate nix packages from URLs
     #nix-index # Database for nixpkgs
     #nixpkgs-review # Review nixpkgs PRs
    nix-output-monitor # Shows extra information on nix commands

    ## Filsesystem utilities
    xfsprogs # XFS filesystem
    ddrutility #Set of tools for HDD rescure
    exfatprogs # ExFAT filesystem
    btrfs-progs # BTRFS filesystem
    ntfs3g # NTFS filesystem
     #ntfs2btrfs # Converts NTFS to BTRFS
    scrounge-ntfs # NTFS data recovery
    
    ## CLI tools & utilities
    fd # Find, but faster
    bc # Calculator
    zip # What it says on the tin
    btop # System metrics and process viewer
    tldr # Simpler manual pages
    wget # Retrieves files over HTTP, HTTPS, and FTP
    curl # Pulls data from a URL
    bash # Terminal shell
    file # Shows type of files
    tree # Tree view of directory structure
    unzip # What it says on the tin
    gnupg # Create encryption keys
    s-tui # Metrics and stress testing
    udiskie # Disk automount
    busybox # Utilities
    ripgrep # Searches files for a given input
    killall # Kills all
    usbutils # USB utils
    pciutils # PCI utils
    moreutils # Woah, even more utils
    libsecret # Library for storing and retrieving secrets
    git-crypt # Transparent file encryption in git
    undervolt # Utility to change CPU settings
    android-tools # Commands for interfacing with android devices
    magic-wormhole # Direct file sharing

 ];

}
