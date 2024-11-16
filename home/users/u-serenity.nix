{ self, inputs, outputs, lib, config, pkgs, ... }:

{

  imports = [
    ## Import user theme
    ../desktop/resources/themes/SerenityOS.nix
    ## Import shared home config
    ../common
  ];

  home = {
    ## Declare user specific packages
    packages = with pkgs; [

    ]; 
  };

}
