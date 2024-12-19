{ inputs, lib, config, pkgs, ... }:

{

  imports = [ ];

  system.activationScripts.diff = {
    supportsDryActivation = true;
    text = ''
      ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff \
          /run/current-system "$systemConfig"
    '';
  }; 

  nixpkgs = {

    config = {
      allowUnfree = true;
      ## Place insecure packages here
      permittedInsecurePackages = [ "olm-3.2.16" ];
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
  #nix.registry = (lib.mapAttrs (_: flake: { inherit flake; }))
  #  ((lib.filterAttrs (_: lib.isType "flake")) inputs);
  ## This will additionally add your inputs to the system's legacy channels
  ## Making legacy nix commands consistent as well, awesome!
  #nix.nixPath = [ "/etc/nix/path" ];
  #environment.etc = lib.mapAttrs' (name: value: {
  #  name = "nix/path/${name}";
  #  value.source = value.flake;
  #}) config.nix.registry;
  ## [END - Stolen code, mostly understand from here again]

  programs = {

    ## Neovim declared here too, just in case
    neovim = { enable = true; };

    ## A catgirl's favourite shell - NEEDS OWN NIX MODULE
    fish = { enable = true; };

    ## Added here in case the user level declaration
    ## is wonky with nvim editor?
    git = { enable = true; };

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

  environment = {

    ## Install a stub ELF loader to print an informative
    ## error message in the event that a user attempts
    ## to run an ELF binary not compiled for NixOS.
    stub-ld.enable = true;

    variables = {
      ## Wei have switched to neovim
      ## full-time, sorry Micro. <3
      EDITOR = "neovim";
      VISUAL = "neovim";
      SYSTEMD_EDITOR = "neovim";
    };

    ## All COMMON system-level packages declared here
    systemPackages = with pkgs; [

      ## Nix specific tools
      nix-tree # Dependency tree viewer for nix store
      nix-init # Generate nix packages from URLs
      nix-index # Database for nixpkgs
      nix-output-monitor # Shows extra information on nix commands

      ## Filsesystem utilities
      ddrutility # Set of tools for HDD rescure
      exfatprogs # ExFAT filesystem
      btrfs-progs # BTRFS filesystem
      ntfs3g # NTFS filesystem
      scrounge-ntfs # NTFS data recovery

      ## CLI tools & utilities
      fd # Find, but faster
      bc # Calculator
      nvd # For nixos-rebuild summary
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
      smartmontools # Tools for monitoring HDD health
      magic-wormhole # Direct file sharing

      gay # dw abt it 
      blahaj # dw abt this either 

    ];

  };

}
