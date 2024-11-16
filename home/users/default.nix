{ self, inputs, outputs, lib, config, pkgs, ... }:

{

  imports = [
    inputs.home-manager.nixosModules.default
    ../desktop/resources/themes/default.nix
  ];
   
  users.users = {
    ## Define users like this
    serenity = {
      description = "Serenity Amalgam";
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
	"gamemode"
      ];
      ## be sure to change this with 'passwd'
      initialPassword = "password";
      ## A catgirl's favourite shell
      shell = pkgs.fish;
    };

  };

  home-manager = {
    ## This line passes in specialArgs from flake.nix
    extraSpecialArgs = { inherit inputs outputs; };
    ## This line ensures all packages declared follow the
    ## same nix-channel we declared in the flake.nix
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {

      ## Also make sure to include a user definition here
      serenity = {
        ## This is where the user configs/packages are imported
        imports = [ ./u-serenity.nix];
        home = {
          username = "serenity";
          homeDirectory = "/home/serenity";
        };
      };

    };
  };

}
