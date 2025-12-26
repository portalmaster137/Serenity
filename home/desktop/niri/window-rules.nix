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
      shadow.enable = true;
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
