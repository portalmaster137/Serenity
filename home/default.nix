{ inputs, outputs, config, pkgs, label, version, flakePath, disksPath
, primaryUser, userDesc, homeDir, wallpapersPath, wallpaper, ... }:

let hostname = "${config.networking.hostName}";

in {

  imports = [

    ## Modules
    inputs.home-manager.nixosModules.default # home-manager module
    #inputs.sops-nix.nixosModules.sops # sops-nix module

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

  ## Needed for sops-nix to handle loginPassword
  #sops.secrets.loginPassword.neededForUsers = true;
  #users.mutableUsers = false;

  ## System-level user declarations
  users.users = {
    ${primaryUser} = {
      description = "${userDesc}";
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "gamemode" "audio" ];
      #hashedPasswordFile = config.sops.secrets.loginPassword.path;
      ## A catgirl's favourite shell
      shell = pkgs.fish;
    };
  };

  ## home-manager configuration
  home-manager = {
    verbose = true; # enables verbose output on activation
    extraSpecialArgs = { # passes in specialArgs from flake.nix
      inherit inputs outputs;
      inherit label version;
      inherit flakePath disksPath;
      inherit primaryUser homeDir;
      inherit wallpapersPath wallpaper;
      inherit hostname;
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
          ./home.nix
        ];
        home = {
          username = "${primaryUser}"; # passes username from `flake.nix`
          homeDirectory = "${homeDir}"; # passes homedir from `flake.nix`
          file."Wallpapers" = { # copies wallpapers
            source = ./resources/wallpapers; # from flake directory
            target = "${wallpapersPath}"; # to home directory
            recursive = true; # think this is important, icr
          };
          stateVersion = "24.11"; # IMPORTANT
        };
      };
    };
    backupFileExtension = "backup"; # prevents errors on activation
    useGlobalPkgs = true; # ensures all packages declared follow -
    useUserPackages = true; # the same nix-channel as in the flake.nix
  };

}
