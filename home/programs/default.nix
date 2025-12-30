{ config, pkgs, ... }:

{

  imports = [

    ## Import user themes
    ../resources/themes
    ../resources/themes/SerenityOS.nix

    ## Import shared program configs
    ./web
    ./git
    ./sync
    ./chat
    ./yazi
    ./btop
    ./fish
    ./nvim
    #./fetch
    ./kitty
    ./fastfetch
    ./multimedia

  ];

}
