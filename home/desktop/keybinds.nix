{ pkgs }:

with pkgs;

let

  modifier = "Mod4";
  left = "h";
  down = "j";
  up = "k";
  right = "l";

in
{

  ## Application binds
  "${modifier}+Space" = "menu";
  "${modifier}+q" = "kill";
  #"${modifier}+Space" = "exec ${cfg.config.menu}";
  "${modifier}+Return" = "exec ${kitty}/bin/kitty";
  "${modifier}+Return+shift" = "exec ${kitty}/bin/kitty --floating";
  "${modifier}+Shift+r" = "reload";
  "${modifier}+Alt+Shift+r" = "restart";

  ## Screenshot binds
  "Print" = "exec screenshot window";
  "Print+Shift" = "exec screenshot monitor";
  "Print+${modifier}" = "exec screenshot region";

  ## Brightness, volume, and media controls
  XF86MonBrightnessUp = "exec ${xorg.xbacklight} -inc 20";
  XF86MonBrightnessDown = "exec ${xorg.xbacklight} -dec 20";
  XF86AudioRaiseVolume = "exec ${pulseaudio}/bin/pactl  set-sink-volume @DEFAULT_SINK@ +5%";
  XF86AudioLowerVolume = "exec ${pulseaudio}/bin/pactl  set-sink-volume @DEFAULT_SINK@ -5%";
  XF86AudioMute = "exec ${pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
  XF86AudioPlay = "exec ${playerctl}/bin/playerctl play";
  XF86AudioPause = "exec ${playerctl}/bin/playerctl pause";
  XF86AudioNext = "exec ${playerctl}/bin/playerctl next";
  XF86AudioPrev = "exec ${playerctl}/bin/playerctl prev";


  ## Window controls
  "${modifier}+c" = "split h";
  "${modifier}+v" = "split v";
  "${modifier}+t" = "floating toggle";
  "${modifier}+f" = "fullscreen toggle";
  "${modifier}+s" = "layout stacking";
  #"${modifier}+t" = "layout tabbed";
  #"${modifier}+e" = "layout toggle split";
  "${modifier}+Shift+${left}" = "move left";
  "${modifier}+Shift+${down}" = "move down";
  "${modifier}+Shift+${up}" = "move up";
  "${modifier}+Shift+${right}" = "move right";
  #"${modifier}+a" = "focus parent";
  "${modifier}+Shift+f" = "focus mode_toggle";
  "${modifier}+${left}" = "focus left; exec $movemouse";
  "${modifier}+${down}" = "focus down; exec $movemouse";
  "${modifier}+${up}" = "focus up; exec $movemouse";
  "${modifier}+${right}" = "focus right; exec $movemouse";

  ## Workspace controls
  "${modifier}+1" = "workspace number 1";
  "${modifier}+2" = "workspace number 2";
  "${modifier}+3" = "workspace number 3";
  "${modifier}+4" = "workspace number 4";
  "${modifier}+5" = "workspace number 5";
  "${modifier}+6" = "workspace number 6";
  "${modifier}+7" = "workspace number 7";
  "${modifier}+8" = "workspace number 8";
  "${modifier}+9" = "workspace number 9";
  "${modifier}+0" = "workspace number 10";
  "${modifier}+Shift+1" = "move container to workspace number 1";
  "${modifier}+Shift+2" = "move container to workspace number 2";
  "${modifier}+Shift+3" = "move container to workspace number 3";
  "${modifier}+Shift+4" = "move container to workspace number 4";
  "${modifier}+Shift+5" = "move container to workspace number 5";
  "${modifier}+Shift+6" = "move container to workspace number 6";
  "${modifier}+Shift+7" = "move container to workspace number 7";
  "${modifier}+Shift+8" = "move container to workspace number 8";
  "${modifier}+Shift+9" = "move container to workspace number 9";
  "${modifier}+Shift+0" = "move container to workspace number 10";
  "${modifier}+Alt+${up}" = "move workspace to output up";
  "${modifier}+Alt+${down}" = "move workspace to output down";
  "${modifier}+Alt+${left}" = "move workspace to output left";
  "${modifier}+Alt+${right}" = "move workspace to output right";

}
