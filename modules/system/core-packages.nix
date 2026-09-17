{ inputs, ... }: {

  # module declaration
  flake.nixosModules.packages = { pkgs, ... }: {

    # environment variables
    environment.variables = {
      EDITOR = "helix";
      VISUAL = "helix";
      SYSTEMD_EDITOR = "helix";
    };

    # nix settings
    nix.settings = {

      # for packages not in nixpkgs
      substituters = [
        "name.here"
      ];
      # keys to sign aforementioned packages
      trusted-public-keys = [
        "name.here"
      ];
    };

    # nixpkgs settings
    nixpkgs = {

      # allows crud
      config = {
        allowUnfree = true;
        allowBroken = true;
      };

      # overlays
      overlays = [
        #niri.overlays.niri
      ];

    };

    # options declarations
    programs = {

      # necessary terminal programs
      git.enable = true;
      fish.enable = true;
      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
        #pinentryPackage = [ ];
      };

      # binary support
      nix-ld.enable = true;
      appimage = {
        enable = true;
        binfmt = true;
      };

    };

    # installs a stub elf loader to print an error
    # message in the event that a user attempts
    # to run an elf binary not compiled for nixos.
    environment.stub-ld.enable = true;

    services = {

      # flatpak software
      flatpak = {
        enable = true;
      };

    };

    # packages to include
    environment.systemPackages = with pkgs; [

      # nix utilities
      nvd
      nix-tree
      nix-init
      nix-index
      nix-prefetch
      nix-output-monitor

      # filesystem
      ddrutility
      smartmontools
      ntfs3g
      exfatprogs
      btrfs-progs

      # shells
      fish
      bash

      # core tools
      btop
      helix
      steam-run
      android-cli
      android-tools
      magic-wormhole

      # cli tools
      fd
      bc
      zip
      icu
      doas
      tldr
      wget
      curl
      file
      tree
      unzip
      gnupg
      s-tui
      udiskie
      busybox
      ripgrep
      killall
      usbutils
      pciutils
      moreutils
      libsecret
      git-crypt
      undervolt
    ];

  };

}
