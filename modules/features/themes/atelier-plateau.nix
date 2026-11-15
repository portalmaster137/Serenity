{ self, ... }:
{
  flake.nixosModules.theme-atelier-plateau =
    { pkgs, ... }:
    {
      imports = [ self.nixosModules.theme-common ];
      stylix.image = "${../../../assets/media/wallpapers/purple-waves.png}";
      stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-plateau.yaml";
    };
}
