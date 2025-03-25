{ pkgs, flakePath, disksPath, primaryUser, ... }:

{

  imports = [ ];

  ## Activation Scripts
  ## - these run after using `sudo nixos-rebuild switch --flake .#<hostname>`
  ## - assumes command is run from the flake directory
  system.activationScripts.diff = {
    supportsDryActivation = false;
    ## Prints diff of the nix store and a cute message if rebuild successful
    text = ''
      cp home/scripts/automount/Disks /home/${primaryUser}/

      echo "disksPaths linked successfully <3"
    '';
  };

}
