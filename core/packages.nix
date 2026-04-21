{ pkgs, flakePath, niri, ... }:

{

  # Activation Scripts - runs after using `sudo nixos-rebuild switch`
  system.activationScripts.diff = {
    supportsDryActivation = true;
    # Prints diff of the nix store and a cute message if rebuild successful
    text = ''
      ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff \
          /run/current-system "$systemConfig"

          echo "Rebuild completed successfully <3"
    '';
  };

  # Nixpkgs Settings
  nixpkgs = {
    config = {
      allowUnfree = true; # not doing full foss lol
      allowBroken = true; # I like 'em broken
      permittedInsecurePackages = [ ]; # insert obvious joke here
      #packageOverrides = pkgs: { # package overrides here
        #sygil-plymouth = pkgs.callPackage /home/serenity/repos/sygil-plymouth/package.nix { };
      #};
    };
    # Place package overlays here
    overlays = [
      # Enabled overlays
      niri.overlays.niri # latest niri
      # Disabled overlays
      #inputs.tidalcycles.overlays.default # programmatic music
      #inputs.mac-style-plymouth.overlays.default # for theme
      #inputs.sygil-plymouth.overlays.default # indev theme
    ];
  };
  nix = {
    settings = {
      substituters = [ # for pkgs not in or out of date in nixpkgs
        "https://cache.iog.io"
      ];
      trusted-public-keys = [ # keys to sign the packages 
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      ];
    };
  };

  # System-level Programs
  programs = {
    # Core terminal suite
    git = { enable = true; }; # Mandatory version control
    fish = { enable = true; }; # A catgirls favourite shell
    neovim = { enable = true; }; # Neovim declared here too, just in case
    nh = {
      enable = true; # nixos cli helper
      flake = "${flakePath}"; # Declared in flake.nix
    };
    gnupg.agent = {
      enable = true; # handles encryption keys
      enableSSHSupport = true; # ssh good, lol
      #pinentryPackage = [ ];
    };
    nix-ld = {
      enable = true; # runs unpackaged binaries
      #libraries = with pkgs; [ ];
    };
    appimage = {
      enable = true; # runs "normal" linux applications
      binfmt = true;
    };
  };
  services.flatpak.enable = true; # flatpak just in case
  environment = {
    # Environment Variables
    variables = { # sets neovim to default editor in other apps
      EDITOR = "nvim";
      VISUAL = "nvim";
      SYSTEMD_EDITOR = "nvim";
    };
    # System-level Packages
    systemPackages = with pkgs; [
      # Nix specific tools
      #cabal2nix
      nix-tree # Dependency tree viewer for nix store
      nix-init # Generate nix packages from URLs
      nix-index # Database for nixpkgs
      nix-prefetch # provides info on a url
      nix-output-monitor # Shows extra information on nix commands
      # Filsesystem utilities
      ddrutility # Set of tools for HDD rescure
      exfatprogs # ExFAT filesystem
      btrfs-progs # BTRFS filesystem
      ntfs3g # NTFS filesystem
      # CLI tools & utilities
      fd # Find, but faster
      bc # Calculator
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
    # Install a stub ELF loader to print an informative
    # error message in the event that a user attempts
    # to run an ELF binary not compiled for NixOS.
    stub-ld.enable = true;
  };

}
