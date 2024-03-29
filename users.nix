{ config, lib, pkgs, ... }:

{

  imports = [

    # ./coffee.nix
    ./users/serenity.nix

  ];

  users = {
    defaultUserShell = pkgs.fish;
  };

}
