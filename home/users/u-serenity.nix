{ 
  inputs,
  outputs,
  lib,
  config,
  pkgs, 
  ...
}: {

  imports = [
    ../common
    ../common/themes/SerenityOS.nix
  ];

  home = {

    packages = with pkgs; [

    ]; 
  };

}
