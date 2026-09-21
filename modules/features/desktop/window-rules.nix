{ self, inputs, ... }:

let

  windowRules = [
    {
      geometry-corner-radius =
        let
          radius = 16.0;
        in
        {
          bottom-left = radius;
          bottom-right = radius;
          top-left = radius;
          top-right = radius;
        };
      clip-to-geometry = true;
      draw-border-with-background = false;
    }
    {
      matches = [ { app-id = "kitty"; } ];
      opacity = 0.95;
    }
    {
      matches = [ { is-floating = true; } ];
      default-floating-position = {
        relative-to = "top-left";
        x = 1720;
        y = 720;
      };
      max-height = 720;
      max-width = 1720;
      opacity = 0.95;
      shadow.enable = true;
    }
    {
      matches = [
        {
          at-startup = true;
          title = "btop";
        }
      ];
      open-on-output = "DP-4";
      open-on-workspace = "System";
      open-maximized = true;
    }
    {
      matches = [ { title = "calculator"; } ];
      open-floating = true;
      open-focused = true;
    }
  ];

in

{
  flake.nixosModules.niri-window-rules = { pkgs, ... }: {

    # for home manager functionality
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager.users.serenity = {
      programs.niri.settings = {
        window-rules = windowRules;
        layout = {
          background-color = "transparent";
        };
        layer-rules = [
          {
            matches = [ { namespace = "^noctalia-wallpaper*"; } ];
            place-within-backdrop = true;
          }
        ];
      };
    };
  };
}
