{
  self,
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:

{

  imports = [

  ./git.nix  
  ./yazi.nix
  ./kitty.nix
  ./neofetch.nix

  ];

}
