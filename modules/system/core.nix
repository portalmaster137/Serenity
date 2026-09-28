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

      # installs a stub elf loader to print an error
      # message in the event that a user attempts
      # to run an elf binary not compiled for nixos.
      environment.stub-ld.enable = true;

      # core packages to include in base system
      environment.systemPackages = with pkgs; [

        # tools
        nix-output-monitor # displays more info on nix commands
        steam
        run # emulates fhs environment
        tldr # simpler manual pages
        bc # basic calculator

        # filesystem
        udiskie # disk automount service
        ddrutility # disk recovery
        smartmontools # disk monitoring
        ntfs3g # ntfs support
        exfatprogs # exfat support

        # directory and file management
        fd # find but faster
        zip # compression
        unzip # decompression
        file # shows file types
        tree # shows directory tree structure
        tokei # displays lines of code in repository
        gnupg # encryption key management
        ripgrep # searches files for input
        git-crypt # transparent file encryption in git
        curl # receives data over http/s
        wget # receives files and data over http/s or ftp
        magic-wormhole # sends and receives files directly

        # cli tools
        usbutils # usb utilities
        pciutils # pci utilities
        moreutils # more utilities
        busybox # even more utilities

      ];

    };

}
