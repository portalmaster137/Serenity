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
    ./chat
    ./yazi
    ./btop
    ./fish
    ./nvim
    ./music
    ./fetch
    ./kitty
    ./syncthing
    ./multimedia
    ./music/production.nix

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
