{ inputs, ... }:

{

  # user module declaration
  flake.nixosModules.serenity =

    { config, pkgs, ... }:

    let

      # change this when making a new user
      user = serenity;

    in

    {

      # necessary for home manager function
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      config.userOptions = {
        username = "${user}";
        flakePath = "/home/${user}/SerenityOS";
        wallpaper = "attunement.png";
        colorScheme = "SerenityOS";
      };

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

    };

}
