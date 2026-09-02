{ self, inputs, ... }:

# let bindings
let

  # set your username here
  username = "serenity";

  # qol variable to make paths shorter
  home = "/home/${name}";

in

{

  # user module declaration
  flake.modules.nixos.serenity =

    { pkgs, ... }:

    {

      # modules to include
      modules = [

        # home-manager module
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {

            # home-manager settings
            backupFileExtension = ".bak";
            overwriteBackup = true;
            verbose = true;

            # set home-manager packages to follow system
            useUserPackages = true;
            useGlobalPkgs = true;

            # hm user declaration
            users.serenity = {

              # user specific modules to import
              imports = [
                self.flake.homeModules.core-home
                #self.flake.homeModules.${name}
              ];

            };

          };
        }

      ];

      # user declaration
      users.users.serenity = {

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
