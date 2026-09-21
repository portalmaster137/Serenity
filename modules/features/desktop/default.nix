{ self, inputs, ... }:

{

  # desktop supermodule
  flake.nixosModules.desktop = {

    # modules to include
    imports = [

      # session management
      #self.nixosModules.${greeter}

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
        #"vga=current" # use current video adapater
        #"splash" # unsure ?
        "quiet" # quiet log level
        "loglevel=3" # minimal output on boot
        #"udev.log_priority=3" # more minimising of output on boot
        #"rd.systemd.show_status=false" # unsure ?
        #"rd.udev.log_level=0" # more minimising of output on boot
        #"boot.shell_on_fail" # reboots to basic uefi shell on boot failure
        #"i915.fastboot=1" # unsure ?
        #"plymouth.debug" # I NEED ANSWERS
        #"plymouth.use-simpledrm" # tweak to allow plymouth animations to run smoother
        #"plymouth.ignore-serial-consoles" # unsure ?
      ];
      loader = {
        timeout = 5; # 5 second timeout to default selection
        #grub = {
        #splashImage = null; # hides splashimage
        #timeoutStyle = "hidden"; # hides timeout
        #};
      };
      plymouth = {
        # enables plymouth boot animations
        enable = false;
        extraConfig = "ShowDelay=0";
        #theme = "sygil-plymouth";
        #themePackages = sygil-plymouth;
        #themePackages = with pkgs; [
        #(adi1090x-plymouth-themes.override {
        #selected_themes = [ "circle" ];
        #})
        #];
      };
    };

    # I put fonts here because i didn't know where tf else to put them lol
    # duplicate to home-manager config ?
    fonts = {
      packages =
        with pkgs;
        [
          spleen
          terminus_font
          terminus_font_ttf
          nerd-fonts.symbols-only
        ]
        ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
      fontDir.enable = true;
      fontconfig = {
        defaultFonts = {
          serif = [ "spleen-32x64" ];
          sansSerif = [ "spleen-32x64" ];
          monospace = [ "TerminusTTF" ];
        };
      };
    };

  };

}
