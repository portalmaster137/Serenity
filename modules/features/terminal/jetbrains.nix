{ inputs, ... }:
{
  flake.nixosModules.jetbrains =
    { pkgs, user-parts, ... }:
    {
      environment.systemPackages = with pkgs; [ jetbrains-toolbox ];
    };
}
