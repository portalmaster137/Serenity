{ inputs, ... }: 
{
  imports = [ (import ./hyprland.nix) ]
    ++ [ (import ./config.nix) ]
    ++ [ (import ./variables.nix) ]
    ++ [ (import ./waybar) ]
    ++ [ (import ./wofi) ]
    # ++ [ (import ./stylix) ]
    ++ [ inputs.hyprland.homeManagerModules.default ];
}
