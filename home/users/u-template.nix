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
    inputs.home-manager.nixosModules.default
    ../home.nix
  ];

  home = {

    packages = with pkgs; [

    ];
  };

}
