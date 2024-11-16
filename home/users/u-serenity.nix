{ self, inputs, outputs, lib, config, pkgs, ... }:

{

  imports = [
    ## Import user theme
    ../desktop/resources/themes/SerenityOS.nix
  ];

  home = {
    ## Declare user specific packages
    packages = with pkgs; [

    ]; 
  };

}
