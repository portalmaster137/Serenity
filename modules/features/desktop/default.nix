{ self, inputs, ... }:

{

  # desktop supermodule declaration
  flake.nixosModules.desktop =

    {
      pkgs,
      lib,
      user-parts,
      ...
    }:

    {

      # modules to include
      imports = [

        # window manager
        self.nixosModules.niri

        # desktop shell/status bar
        self.nixosModules.noctalia

        # for home manager functionality
        inputs.home-manager.nixosModules.home-manager

      ];

      # polkit
      security.polkit = {
        enable = true;
      };

      # session management
      environment.variables = {
        XDG_SESSION_TYPE = "wayland";
      };
      services.displayManager.regreet = {
        enable = true;
      };

      # disk management
      services.udisks2.enable = true;
      programs.gnome-disks.enable = true;
      environment.systemPackages = with pkgs; [ gparted ];
      home-manager.users.${user-parts.user.username} = {

        # password prompts
        services.gnome-keyring.enable = true;

        # more desktop applications
        home.packages = with pkgs; [
          gnome-calculator # simple calculator
          gnome-secrets # password manager
          file-roller # archive manager
          obsidian # note taking
          nautilus # file manager
          swayimg # image viewer
          zathura # pdf viewer
          vscodium-fhs # vscode editor
          opencode-desktop
          prismlauncher
        ];

      };

    };

}
