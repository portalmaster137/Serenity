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

  ./programs
  ./git.nix  
  ./yazi.nix
  ./kitty.nix
  ./neofetch
  
  ];

}
