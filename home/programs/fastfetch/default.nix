{ config, pkgs, ... }:

{

  home = {
    packages = with pkgs; [
      peaclock # neat terminal clock applet
      cmatrix # funky terminal matrix rain
    ];
  };

  programs.fastfetch = {
    enable = true;
    package = with pkgs; [
      fastfetch
      #fastfetchMinimal
    ];

    #settings = {
    #"$schema" = "https://github.com/fastfetch=cli/fastfetch/raw/dev/doc/json_schema.json";

    #logo = {

    #};

    #display = {

    #};

    #};

  };

}
