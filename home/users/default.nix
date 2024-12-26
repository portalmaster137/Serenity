{ inputs, outputs, pkgs, flakePath, disksPath, primaryUser, ... }:

{

  imports = [

    ## Modules
    inputs.home-manager.nixosModules.default # home-manager module
    #../../home # home-manager configuration

    ## Users
    #./u-serenity.nix

    ## User themes - 
    ## to set a different theme for a user,
    ## create a theme by copying an existing
    ## one as a template and import it here,
    ## then - I haven't figured it out yet :D
    #../resources # eventually have all theme imports automated
    #../resources/themes # base theme options
    #../resources/themes/SerenityOS.nix # default theme

  ];

  ## Primary user configuration -
  ## to create additional users, copy all options
  ## below to a new file akin to `u-username.nix`,
  ## or `u-username/default.nix` with more modules,
  ## making sure to replace all instances of
  ## `${primaryUser}` with the new username.

  ## System-level user declarations
  users.users = {
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

  ## home-manager configuration
  home-manager = {
    verbose = true; # enables verbose output on activation
    extraSpecialArgs = { # passes in specialArgs from flake.nix
      inherit inputs outputs;
      inherit primaryUser;
      inherit flakePath disksPath;
    };
    users = {
      ${primaryUser} = {
        imports = [
          ## Home configuration -
          ## currently all users share the same home
          ## configuration, though each has separate
          ## home directories. Additional modules
          ## can be declared alongside `u-username/default.nix`
          ## and then imported in this section.
          #../../home
          ./u-serenity.nix
        ];
        home = {
          username = "${primaryUser}";
          homeDirectory = "/home/${primaryUser}";
        };
      };
    };
    backupFileExtension = "backup"; # prevents errors on activation
    useGlobalPkgs = true; # ensures all packages declared follow -
    useUserPackages = true; # the same nix-channel as in the flake.nix
  };

}
