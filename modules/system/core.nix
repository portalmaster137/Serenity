{ self, inputs, ... }:

{

  # common module declaration
  flake.nixosModules.core =

    { lib, pkgs, ... }:

    {

      # other modules to load
      imports = [ ];

      # extra features
      nix.settings.experimental-features = [

        # flake based config requires flakes
        "flakes"

        #fancier nix usage
        "nix-command"

      ];

      # compresses half the ram for use as swap
      zramSwap.enable = true;

      # locale settings
      i18n = {
        defaultLocale = "en_AU.UTF-8";
        supportedLocales = [
          "en_AU.UTF-8/UTF-8"
          "en_US.UTF-8/UTF-8"
        ];
      };

      # meanjin time
      time.timeZone = lib.mkDefault "Australia/Brisbane";

      # don't touch this
      system.stateVersion = lib.mkDefault "24.11";
      documentation.dev.enable = true;

      # nixpkgs settings
      nixpkgs = {
        # allows broken and ideologically impure packages
        config = {
          allowUnfree = true;
          allowBroken = true;
        };
        # nixpkgs overlays
        overlays = [ ];
      };

      programs = {
        # necessary terminal programs
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

      # flatpak support
      services.flatpak = {
        enable = true;
      };

      # installs a stub elf loader to print an error
      # message in the event that a user attempts
      # to run an elf binary not compiled for nixos.
      environment.stub-ld.enable = true;

      # core packages to include in base system
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

        # compat tools
        steam-run
        android-cli
        android-tools

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
        tokei
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
        magic-wormhole

      ];

    };

}
