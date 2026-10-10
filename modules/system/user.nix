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
        self.nixosModules.theme-tokyo-night

        # other modules to include
        self.nixosModules.syncthing # for syncing personal files

      ];

      # configure user here
      nixos.user-parts = {
        user = {
          username = "porta";
          avatar = "../../assets/media/avatars/carpet.jpg";
          home-directory = "/home/porta/";
          default-locale = "en_US.UTF-8";
        };
        git = {
          username = "Porta";
          email = "portalmaster137@gmail.com";
        };

      };

      # nixos user declaration
      users.users.${user-parts.user.username} = {
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
