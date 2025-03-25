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
      cd ~ && ln -s /run/media/${primaryUser}/ Disks

        echo "disksPaths linked successfully <3"
    '';
  };

  system.activationScripts.flakeLink = {
    supportsDryActivation = false;
    ## Prints diff of the nix store and a cute message if rebuild successful
    text = ''
      cd ~ && runas -u ${primaryUser} -- cp -r /home/${primaryUser}/flakes/nixdots/* ${flakePath}/

        echo "flakePath linked successfully <3"
    '';
  };

}
