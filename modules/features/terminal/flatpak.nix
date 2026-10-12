{ inputs, ... }:
{
  flake.nixosModules.flatpak =
  { pkgs, user-parts, ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];
    services.flatpak.enable = true;
  };
}
