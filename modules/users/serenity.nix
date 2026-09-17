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
        inherit home;
        isNormalUser = true;

        # groups to include user in
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
