{ inputs, ... }:
{
  flake.nixosModules.go =
  {pkgs, user-parts, ...}:
  {
    imports = [ inputs.home-manager.nixosModules.home-manager ];
    environment.systemPackages = with pkgs; [ go gopls ];
  };
}
