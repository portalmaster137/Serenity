{ pkgs, ... }:

{

  imports = [

    ## Import WM/Desktop config
    ../scripts
    ./desktop

    ## Import user themes
    ../resources/themes
    ../resources/themes/SerenityOS.nix

    ## VM GPU stuff ?
    ./looking-glass.nix

    ## Import shared program configs
    ./web
    ./git
    ./obs
    ./chat
    ./yazi
    ./btop
    ./fish
    ./nvim
    ./fetch
    ./kitty
    ./multimedia.nix
  ];

  home = {

    packages = with pkgs; [

      ## Misc.
      cmatrix
      peaclock

      ## Temporary
      themix-gui # GTK theme maker
    ];

    stateVersion = "24.11";

  };

}
