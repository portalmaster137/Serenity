{ pkgs, ... }:

{

  imports = [

    ## Import WM/Desktop config
    ../scripts
    ./desktop

    ## Import shared program configs
    ./shared

    ## VM GPU stuff ?
    ./optional/looking-glass.nix

    ## Import user themes
    ../resources/themes
    ../resources/themes/SerenityOS.nix

  ];

  home = {

    packages = with pkgs;
      [
        ## Temp.
        themix-gui # GTK theme maker
      ];

    stateVersion = "24.11";

  };

}
