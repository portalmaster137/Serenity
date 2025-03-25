{ pkgs, flakePath, disksPath, primaryUser, ... }:

{

  imports = [ ];

  ## Activation Scripts
  ## - these run after using `sudo nixos-rebuild switch --flake .#<hostname>`
  ## - assumes command is run from the flake directory
  system.activationScripts.disksLink = {
    supportsDryActivation = false;
    ## Prints diff of the nix store and a cute message if rebuild successful
    text = ''
      {
          cd ~ && ln -s Disks /run/media/${primaryUser}/
          echo "disksPaths linked successfully <3"
      } || {
          echo "diskPaths linking failed </3"
          echo "Disable this module if paths have already been linked."
          echo "(run `cd ~/Disks` to see if paths are linked)"
      }
    '';
  };

}
