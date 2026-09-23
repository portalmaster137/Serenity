{ self, inputs, ... }:

{

  # system packages module declaration
  flake.nixosModules.core-packages =

    { pkgs, ... }:

    {

      # nix settings
      nix.settings = {
        # for packages not in nixpkgs
        #substituters = [
        #"name.here"
        #];
        # keys to sign aforementioned packages
        #trusted-public-keys = [
        #"name.here"
        #];
      };

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
