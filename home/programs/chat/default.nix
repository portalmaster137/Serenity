{ pkgs, ... }:

{

  home = {
    packages = with pkgs; [
      #telegram-desktop # telegram, obviously
      #fractal-next # GTK matrix client
      #fractal # GTK matrix client
      vesktop # custom discord client
    ];
  };

  programs = {

    #nheko.enable = true; # QT matrix client
    #https://mynixos.com/home-manager/option/programs.nheko.settings

  };

}
