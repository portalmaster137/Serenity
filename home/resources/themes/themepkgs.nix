{ pkgs, ... }:

{

  home.packages = with pkgs; [
    materia-theme-transparent
    materia-theme
    colloid-gtk-theme
    colloid-kde
    adapta-gtk-theme
    adapta-kde-theme
    gnome-themes-extra
    materia-theme
  ];

}
