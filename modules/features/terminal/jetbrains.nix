{ ... }:
{
  flake.nixosModules.jetbrains =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ jetbrains-toolbox ];
    };
}
