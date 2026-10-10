{ inputs, ... }:
{
  flake.nixosModules.cdevenv =
  { pkgs, user-parts, ... }:
  {
    imports = [ inputs.home-manager.nixosModules.home-manager ];
    environment.systemPackages = with pkgs; [ libclang neocmakelsp cmake gcc gnumake ];
  };
}
