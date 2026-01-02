_:
let
  windowRules = [
    {
      geometry-corner-radius = let radius = 16.0;
      in {
        bottom-left = radius;
        bottom-right = radius;
        top-left = radius;
        top-right = radius;
      };
      clip-to-geometry = true;
      draw-border-with-background = false;
      opacity = 0.95;
    }
    {
      matches = [{ is-floating = true; }];
      default-floating-position = {
        relative-to = "top-left";
        x = 1720;
        y = 720;
      };
      max-height = 720;
      max-width = 1720;
      shadow.enable = true;
    }
    {
      matches = [{title = "python\s[A-Za-z]+\.py";}];
      open-floating = true;
      open-focused = true;
    }
    {
      matches = [{title = "Python Turtle Graphics";}];
      open-floating = true;
      open-focused = true;
    }
  ];
in {
  programs.niri.settings = {
    window-rules = windowRules;
    layout = { background-color = "transparent"; };
    layer-rules = [{
      matches = [{ namespace = "^noctalia-wallpaper*"; }];
      place-within-backdrop = true;
    }];
  };
}
