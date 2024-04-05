{ inputs, pkgs, ...}:

{

  home.packages = with pkgs; [
    wayland
    
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast

    hyprlock
    hyprpaper
    hyprpicker
    hyprcursor

    wofi
    grim
    dunst
    slurp
    nm-applet
    overskride
    cliphist
    wl-clip-persist
    wf-recorder
    
  ];
  
  systemd.user.targets.hyprland-session.Unit.Wants = [
  "xdg-desktop-autostart.target"
  ];
  
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland = {
      enable = true;
      # hidpi = true;
    };
  };
  
}
