{ self, inputs, ... }:

{

  # common module declaration
  flake.nixosModules.core =

    { lib, pkgs, ... }:

    {

      # other modules to load
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # don't touch this
      system.stateVersion = lib.mkDefault "24.11";
      documentation.dev.enable = true;

      # plymouth settings
      boot = {
        plymouth = {
          enable = true;
          extraConfig = "ShowDelay=0";
          themePackages = with pkgs; [
            (adi1090x-plymouth-themes.override {
              selected_themes = [ "circle" ];
            })
          ];
        };
        # kernel and boot settings for plymouth
        initrd.verbose = false;
        consoleLogLevel = 3;
        kernelParams = [
          # grub kernel parameters, set to prevent excessive output on boot
          "vga=current" # use current video adapater
          "splash" # unsure ?
          "quiet" # quiet log level
          "loglevel=3" # minimal output on boot
          "udev.log_priority=3" # more minimising of output on boot
          "rd.systemd.show_status=false" # unsure ?
          "rd.udev.log_level=0" # more minimising of output on boot
          "boot.shell_on_fail" # reboots to basic uefi shell on boot failure
          "i915.fastboot=1" # unsure ?
          "plymouth.debug" # I NEED ANSWERS
          "plymouth.use-simpledrm" # tweak to allow plymouth animations to run smoother
          "plymouth.ignore-serial-consoles" # unsure ?
        ];
      };

      # extra features
      nix.settings.experimental-features = [
        # flake based config requires flakes
        "flakes"
        #fancier nix usage
        "nix-command"
      ];

      # compresses half the ram for use as swap
      zramSwap.enable = true;

      # configures disk automount service
      home-manager.users.serenity = {
        services.udiskie = {
          enable = true;
          tray = "always";
          notify = true;
          automount = true;
        };
      };

      # meanjin time
      time.timeZone = lib.mkDefault "Australia/Brisbane";

      # locale settings
      i18n = {
        defaultLocale = "en_AU.UTF-8";
        supportedLocales = [
          "en_AU.UTF-8/UTF-8"
          "en_US.UTF-8/UTF-8"
        ];
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

      # for encryption
      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
        #pinentryPackage = [ ];
      };

      # binary support
      # installs a stub elf loader to print an error
      # message in the event that a user attempts
      # to run an elf binary not compiled for nixos.
      environment.stub-ld.enable = true;
      programs.nix-ld.enable = true;
      programs.appimage = {
        enable = true;
        binfmt = true;
      };
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
