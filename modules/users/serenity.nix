{ self, inputs, ... }:

let

  # configure user here
  ${user} = serenity;
  ${avatar} = ../../assets/media/avatar.png;
  ${wallpaper} = ../../assets/media/wallpapers/mimaKirigoe.jpg;

in

{

  # user module declaration
  flake.nixosModules.${user} =

    { pkgs, config, ... }:

    {

      imports = [

        # necessary for home manager function
        inputs.home-manager.nixosModules.home-manager

        # select user theme
        self.nixosModules.theme-autogen

      ];

      # nixos user declaration
      users.users.${user} = {

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
        users.${user} = {
          home.stateVersion = "24.11";
          nixpkgs.config.allowUnfree = true;
        };
      };

    };

}
