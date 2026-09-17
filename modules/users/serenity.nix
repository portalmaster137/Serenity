{ self, inputs, ... }:

{

  # necessary for home manager function
  #imports = [ inputs.home-manager.nixosModules.home-manager ];

  # user module declaration
  flake.nixosModules.serenity =

    { pkgs, config, ... }:

    {

      # necessary for home manager function
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      fish.enable = true;

      # user declaration
      users.users.serenity = {

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

      environment.systemPackages = with pkgs; [ home-manager ];

      # home manager settings
      home-manager = {
        verbose = true;
        overwriteBackup = true;
        backupFileExtension = ".bak";
        useGlobalPkgs = true;
        useUserPackages = true;
        users.serenity = {
          home.stateVersion = "24.11";
          nixpkgs.config.allowUnfree = true;
          imports = [ ];
        };
      };

    };

}
