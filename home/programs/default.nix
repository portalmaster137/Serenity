{ config, pkgs, ... }:

{

  imports = [

    ## Import user themes
    ../resources/theme
    ../resources/theme/SerenityOS.nix

    ## Import shared program configs
    ./web
    ./git
    ./sync/postActivation.nix
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
