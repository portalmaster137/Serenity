{ self, inputs, ... }: {

  # this module defines all hosts and allocates users to those hosts
  flake.nixosConfigurations =
    let

      # users to include on machine
      username = "serenity";
      #username2 = "foobar";
      
      # shorten paths
      inherit (inputs.nixpkgs.lib) nixosSystem;
      homeImports = import "${self}/home/profiles";
      mod = "${self}/modules/system";
      # get the basic config to build on top of
      inherit (import mod) base;
      # get these into the module system
      specialArgs = { inherit inputs self; };
    in 

    {

      # declare hosts here
      hades = nixosSystem {
        inherit specialArgs;
        modules = [

          # specify host config directory
          ./hades

          # users to include on machine
          "${mod}/users/u-${username}.nix"
          #"${mod}/users/u-${username2}.nix"
          
          # home manager
          "${mod}/misc/hm-parts.nix"
          {
            home-manager = {

              # misc. hm settings
              extraSpecialArgs = specialArgs;
              backupFileExtension = ".hm-backup";

              # user specific hm configurations present on machine            
              users.${username}.imports = homeImports."${username}";
              #users.${username2}.imports = homeImports."${username2}";

            };
          }

        ];
      };

}
