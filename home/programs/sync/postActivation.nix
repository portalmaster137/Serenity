{ inputs, outputs, lib, config, pkgs, user, homeDirectory, flakePath, disksPath
, ... }:

{

  ## Work in progress - to fix/configure:
  ## - automatically copy flake repo to desired path
  ## - automatically copy sync directories to to desired paths
  ## - expand script with a try/catch block to provide output for failed links
  ## - expand script to only run if desired directories are NOT already linked

  ## To utilise this script place the following option into some system-level module
  #imports = [ ./path/to/postActivation.nix ];

  ## Runs after using `sudo nixos-rebuild switch --flake .#<hostname>`
  system.activationScripts.disksLink = {
    supportsDryActivation = false;
    ## Prints status of run commmand with a cute message if successful
    text = ''
      cd ~ && ln -s Disks /run/media/${user}/*
      echo "Current variables required are:"
      echo "primaryUser - ${user}"
      echo "homeDir - ${homeDirectory}"
      echo "current paths linked are:"
      echo "flakePath - ${flakePath}"
      echo "disksPath - ${disksPath}"
      echo "<3"
    '';
  };

}
