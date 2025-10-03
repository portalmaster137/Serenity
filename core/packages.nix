{ inputs, outputs, pkgs, flakePath, niri, ... }:

{

  imports = [ ];

  ## Activation Scripts
  ## - these run after using `sudo nixos-rebuild switch`
  system.activationScripts.diff = {
    supportsDryActivation = true;
    ## Prints diff of the nix store and a cute message if rebuild successful
    text = ''
      ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff \
          /run/current-system "$systemConfig"

          echo "Rebuild completed successfully <3"
    '';
  };

  ## Nixpkgs Settings
  nixpkgs = {
    config = {
      ## Not doing full-FOSS lol
      allowUnfree = true;
      ## Place insecure packages here
      permittedInsecurePackages = [ "olm-3.2.16" ];
    };
    ## Overlays - BROKEN FOR NOW 
    overlays = [
      niri.overlays.niri
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

  ## Nix settings for package related stuff
  nix = {
    settings = {
      substituters = [ # for pkgs not in or out of date in nixpkgs
      ];
      trusted-public-keys = [ ];
    };
  };

  ## System-level Programs
  programs = {
    git = { enable = true; }; # Mandatory version control
    fish = { enable = true; }; # A catgirls favourite shell
    neovim = { enable = true; }; # Neovim declared here too, just in case
    ## NixOS CLI helper
    nh = {
      enable = true;
      flake = "${flakePath}"; # Declared in flake.nix
    };
    ## For handling encryption keys
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      #pinentryPackage = [ ];
    };
    ## For running unpackaged binaries
    nix-ld = {
      enable = true;
      #libraries = with pkgs; [ ];
    };
    ## To run "normal" linux applications seamlessly
    appimage = {
      enable = true;
      binfmt = true;
    };
  };

  ## Flatpak, just in case
  services.flatpak.enable = true;

  environment = {
    ## Environment Variables
    variables = { # sets neovim to default editor in other apps
      EDITOR = "nvim";
      VISUAL = "nvim";
      SYSTEMD_EDITOR = "nvim";
    };
    ## Install a stub ELF loader to print an informative
    ## error message in the event that a user attempts
    ## to run an ELF binary not compiled for NixOS.
    stub-ld.enable = true;
    ## System-level Packages
    systemPackages = with pkgs; [
      ## Nix specific tools
      nix-tree # Dependency tree viewer for nix store
      nix-init # Generate nix packages from URLs
      nix-index # Database for nixpkgs
      nix-prefetch # provides info on a url
      nix-output-monitor # Shows extra information on nix commands
      ## Filsesystem utilities
      ddrutility # Set of tools for HDD rescure
      exfatprogs # ExFAT filesystem
      btrfs-progs # BTRFS filesystem
      ntfs3g # NTFS filesystem
      ## CLI tools & utilities
      fd # Find, but faster
      bc # Calculator
      nvd # For nixos-rebuild summary
      zip # What it says on the tin
      doas # alternative to sudo
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
      steam-run # Used for running funky binaries and executables
      android-tools # Commands for interfacing with android devices
      smartmontools # Tools for monitoring HDD health
      magic-wormhole # Direct file sharing
    ];
  };

}
