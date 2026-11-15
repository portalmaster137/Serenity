{ ... }:
{
  flake.nixosModules.go =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        go
        gopls
      ];
    };
}
