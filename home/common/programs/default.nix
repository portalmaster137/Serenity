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
   #./nixvim
  ./neofetch.nix
  
  ];

}
