{ inputs, ... }:

{

  # user module declaration
  flake.nixosModules.serenity =

    { inputs, pkgs, ... }:

    let

      # change this when making a new user
      user = "serenity";

    in

    {

      # necessary for home manager function
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # user declaration
      users.users.${user} = {

        # remember to change this
        initialPassword = "password";

        # permissions management
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "networkmanager"
        ];

        # dont hardcode this
        # catgirl shell
        shell = pkgs.fish;

      };

      # home manager settings
      home-manager = {
        verbose = true;
        overwriteBackup = true;
        backupFileExtension = ".bak";
        useGlobalPkgs = true;
        useUserPackages = true;
        users.serenity = {
          home.stateversion = "24.11";
          nixpkgs.config.allowUnfree = true;
        };
      };

    };

}
