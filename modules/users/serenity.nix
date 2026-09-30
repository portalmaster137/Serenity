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

    let

      username = "serenity";

    in

    {

      imports = [

        # necessary for home manager function
        inputs.home-manager.nixosModules.home-manager

        # necessary for multi-user functionality
        #self.nixosModules.user-options

        # select user theme
        self.nixosModules.theme-atelier-plateau

      ];

      nixos.user-parts = {
        user.username = "serenity";
      };

      # configure user here
      #config.user-options = {
      #username = "serenity";
      #dots = "/home/serenity/SerenityOS";
      # see `modules/features/stylix.nix` for theme declared above
      #};

      # nixos user declaration
      users.users.${username} = {

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
        users.${username} = {
          home.stateVersion = "24.11";
          nixpkgs.config.allowUnfree = true;
        };

      };

    };

}
