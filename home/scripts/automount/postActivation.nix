{ pkgs, flakePath, disksPath, primaryUser, ... }:

{

  imports = [ ];

  ## Runs after using `sudo nixos-rebuild switch --flake .#<hostname>`
  system.activationScripts.disksLink = {
    supportsDryActivation = false;
    ## Prints status of run commmand with a cute message if successful
    text = ''
      cd ~ && ln -s Disks /run/media/${primaryUser}/*
      echo "disksPaths linked successfully <3"
    '';
  };

}
