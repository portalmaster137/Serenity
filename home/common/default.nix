{
  self,
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

  imports = [

  ./git.nix  
  ./yazi.nix
  ./kitty.nix
  ./neofetch.nix

  #../sway
  ../hypr
  
  ];

  home = {

    packages = with pkgs; [

      ## desktop environment
      gnome-keyring
      opentabletdriver
      #gnome-calculator
      syncthing-tray
      #gnome-calendar
      gnome-secrets
      appimage-run
      #qt5-wayland
      #qt6-wayland
      #gnome-clocks
      pavucontrol
      image-roll
      nautilus
      peaclock
      cmatrix
      hyfetch
      zathura
      kitty
      micro
      btop
      eog

      ## multimedia & games
      neural-amp-modeler-lv2
      thunderbird
      transmission-gtk
      nicotine-plus
      osu-lazer-bin
      bespokesynth
      easyeffects
      obs-studio
      metronome
      inkscape
      obsidian
      vcv-rack
      cardinal
      audacity
      jellyfin
      syncplay
      swayimg
      shotcut
      clapper
      ydotool
      # spotify
      blender
      helvum
      ardour
      # steam # what
      gimp
      vlc
      
      ## chat & web
      lagrange
      vesktop
      fractal # fix gnome-keyring 
      tor 
    ];

    stateVersion = "23.11";
    
  };

  programs = {
    home-manager.enable = true;
    starship.enable = true;
     #steam.enable = true; # apparently steam doesnt exist in home-manager :thonk:
    fish.enable = true;
    git.enable = true;
    firefox.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;  
    };
  };

  services = {
    kdeconnect = {
      enable = true;
      indicator = true;
    };
    gnome-keyring = {
      enable = true;
      #components = [ ];
    };
  };
  
  systemd.user.startServices = "sd-switch";

}
