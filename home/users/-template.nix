{ 
  inputs,
  outputs,
  lib,
  config,
  pkgs, 
  ...
}:

{

  imports = [
    ../home.nix
  ];

  home = {

    packages = with pkgs; [

    ];

    stateVersion = "23.11";
  };

}
