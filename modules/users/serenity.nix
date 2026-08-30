{ self, inputs, ... }:

# let bindings
let

  # set your username here
  name = "serenity";

  # qol variable to make paths shorter
  home = "/home/${name}";

in

{

  # user module declaration
  flake.nixosModules.u-serenity =

    { pkgs, ... }:

    {

      # modules to include
      modules = [

        # home-manager module
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {

            # home-manager settings
            backupFileExtension = "backup";
            overwriteBackup = true;
            verbose = true;

            # set home-manager packages to follow system
            useUserPackages = true;
            useGlobalPkgs = true;

            # hm user declaration
            users.${name} = {

              # user specific modules to import
              imports = [
                self.flake.homeModules.baseHome
              ];

            };

          };
        }

      ];

      # user declaration
      users.users.${name} = {

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
        shell = pkgs.fish;

      };

    };

}
