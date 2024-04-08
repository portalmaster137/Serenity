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
    ./users.nix
  ];

}
