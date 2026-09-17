{ inputs, ... }:

{

  # user module declaration
  flake.nixosModules.serenity =

    { config, pkgs, ... }:

    let

      username = config.userOptions.username;

    in

    {

      # necessary for home manager function
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # user declaration
      users.users.${username} = {

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

    };

}
