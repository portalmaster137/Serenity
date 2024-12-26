{ inputs, outputs, pkgs, flakePath, disksPath, primaryUser, ... }:

{

  imports = [ inputs.home-manager.nixosModules.default ];

  users.users = {
    ## Define users like this
    ${primaryUser} = {
      description = "Serenity Amalgam";
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "gamemode" "audio" ];
      ## be sure to change this with 'passwd'
      initialPassword = "password";
      ## A catgirl's favourite shell
      shell = pkgs.fish;
    };

  };

  home-manager = {
    ## Enables verbose output on activation
    verbose = true;
    ## This line passes in specialArgs from flake.nix
    extraSpecialArgs = {
      inherit inputs outputs;
      inherit primaryUser;
      inherit flakePath disksPath;
    };
    ## This line ensures all packages declared follow the
    ## same nix-channel we declared in the flake.nix
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users = {

      ## Also make sure to include a user definition here
      ${primaryUser} = {
        ## This is where the user configs/packages are imported
        imports = [ ./u-${primaryUser}.nix ];
        home = {
          username = "${primaryUser}";
          homeDirectory = "/home/${primaryUser}";
        };
      };

    };
  };

}
