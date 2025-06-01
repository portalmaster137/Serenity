{ pkgs, ... }:

{

  imports = [

    ## Import user themes
    ../resources/themes
    ../resources/themes/SerenityOS.nix

    ## Import shared program configs
    ./web
    ./git
    ./obs
    ./sync
    ./chat
    ./yazi
    ./btop
    ./fish
    ./nvim
    ./misc
    ./music
    ./fetch
    ./kitty
    ./multimedia

  ];

}
