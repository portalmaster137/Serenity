# #https://mynixos.com/home-manager/option/programs.nheko.settings
{ pkgs, ... }:

{

  home = {
    packages = with pkgs; [ telegram-desktop fractal-next fractal vesktop ];
  };

  programs = {
    nheko = {
      enable = true;
      settings = { };
    };
  };

}
