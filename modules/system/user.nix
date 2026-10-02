{ self, inputs, ... }:

{

  # user module declaration
  flake.nixosModules.serenity =

    {
      pkgs,
      config,
      user-parts,
      ...
    }:

    {

      imports = [

        # necessary for home manager function
        inputs.home-manager.nixosModules.home-manager

        # select user theme
        self.nixosModules.theme-atelier-plateau

      ];

      # configure user here
      nixos.user-parts = {
        user = {
          username = "serenity";
          avatar = "../../assets/media/avatars/carpet.jpg";
          home-directory = "/home/serenity/";
          default-locale = "en_AU.UTF-8";
        };
        git = {
          username = "serenity-F";
          email = "serenity-F@noreply.codeberg.org";
        };

      };

      # nixos user declaration
      users.users.${user-parts.user.username} = {

        # remember to change this
        initialPassword = "password";

        # permissions management
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "networkmanager"
        ];

        # dont hardcode this ?
        # catgirl shell
        shell = pkgs.fish;

      };

      # needed or nix yells at me
      programs.fish.enable = true;

      # home manager settings
      home-manager = {

        verbose = true;
        overwriteBackup = true;
        backupFileExtension = ".bak";
        useUserPackages = true;

        # home manager user declaration
        users.${user-parts.user.username} = {
          home.stateVersion = "24.11";
          nixpkgs.config.allowUnfree = true;
        };

      };

    };

}
