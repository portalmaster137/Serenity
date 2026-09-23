{ self, inputs, ... }:

{

  # user module declaration
  flake.nixosModules.serenity =

    { pkgs, config, ... }:

    {

      # necessary for home manager function
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # needed or nix yells at me
      programs.fish.enable = true;

      # nixos user declaration
      users.users.serenity = {

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

      # not entirely sure this is necessary tbh
      environment.systemPackages = with pkgs; [ home-manager ];

      # home manager settings
      home-manager = {
        verbose = true;
        overwriteBackup = true;
        backupFileExtension = ".bak";

        # need to disable soon ?
        useGlobalPkgs = true;
        useUserPackages = true;

        # home manager user declaration
        users.serenity = {
          home.stateVersion = "24.11";
          nixpkgs.config.allowUnfree = true;

          # user specific modules to include
          #imports = [ ];
        };
      };

    };

}
