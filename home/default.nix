{ 
  inputs, outputs, config, pkgs, 
  label, flakePath, 
  user, userDescription,
  homeDirectory, 
  wallpapersPath, wallpaper, 
  avatarsPath, avatar,
  ... 
}:

let hostname = "${config.networking.hostName}";

in {

  imports = [ ];

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
    ${user} = {
      description = "${userDescription}";
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
      inherit hostname;
      inherit label flakePath;
      inherit user userDescription;
      inherit homeDirectory;
      inherit wallpapersPath wallpaper;
      inherit avatarsPath avatar;
    };
    users = {
      ${user} = {
        imports = [
          ## Home configuration -
          ## currently all users share the same home
          ## configuration, though each has separate
          ## home directories. Additional modules
          ## can be declared alongside `u-username/default.nix`
          ## and then imported in this section.
          #./resources/theme
          ./desktop
          ./programs
          ./scripts
        ];
        home = {
          stateVersion = "24.11"; # IMPORTANT
          #programs.home-manager.enable = true;
          #systemd.user.startServices = "sd-switch";
          username = "${user}"; # passes username from `flake.nix`
          homeDirectory = "${homeDirectory}"; # passes homedir from `flake.nix`
          file."avatar" = {
            source = ./resources/theme/avatar.jpg;
            target = "${avatarsPath}";
            recursive = true;
          };
          file."Wallpapers" = { # copies wallpapers
            source = ./resources/wallpapers; # from flake directory
            target = "${wallpapersPath}"; # to home directory
            recursive = true; # think this is important, icr
          };
        };
      };
    };
  };

}
