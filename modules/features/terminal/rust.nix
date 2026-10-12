{ inputs, ... }:
{
  flake.nixosModules.rust =
  {pkgs, user-parts, ...}:
  {
    imports = [ inputs.home-manager.nixosModules.home-manager ];
    environment.systemPackages = with pkgs; [ rust-analyzer ];
  };
}
