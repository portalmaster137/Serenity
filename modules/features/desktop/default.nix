{ self, inputs, ... }:

{

  # desktop supermodule declaration
  flake.nixosModules.desktop =

    { pkgs, lib, ... }:

    {

      # modules to include
      imports = [

        # window manager
        self.nixosModules.niri

        # application launcher
        self.nixosModules.wofi

        # desktop shell/status bar
        self.nixosModules.noctalia

        # theme management
        #self.nixosModules.stylix

        # for home manager functionality
        inputs.home-manager.nixosModules.home-manager

      ];

      # Boot/GRUB options
      boot = {
        #bootspec.enable = true;
        consoleLogLevel = 3;
        initrd = {
          verbose = false;
          systemd = {
            enable = true;
          };
        };
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
        loader = {
          timeout = lib.mkDefault 5; # 5 second timeout to default selection
        };
        plymouth = {
          # enables plymouth boot animations
          enable = true;
          extraConfig = "ShowDelay=0";
          themePackages = with pkgs; [
            (adi1090x-plymouth-themes.override {
              selected_themes = [ "circle" ];
            })
          ];
        };
      };

      # login manager
      services.displayManager.regreet = {
        enable = true;
      };

      # polkit
      security.polkit = {
        enable = true;
      };

      # disk management
      services.udisks2.enable = true;
      programs.gnome-disks.enable = true;

      environment.systemPackages = with pkgs; [

        # disk management pkgs
        gparted
        udiskie

      ];

      environment.variables = {
        XDG_SESSION_TYPE = "wayland";
      };

      home-manager.users.serenity = {

        # password prompts
        services.gnome-keyring.enable = true;

        # disk automount
        services.udiskie = {
          enable = true;
          tray = "always";
          notify = true;
          automount = true;
        };

        home.packages = with pkgs; [

          # more desktop applications
          gnome-calculator # simple calculator
          gnome-secrets # password manager
          file-roller # archive manager
          obsidian # note taking
          nautilus # file manager
          swayimg # image viewer
          zathura # pdf viewer

        ];

      };
    };

}
