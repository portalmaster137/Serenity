{ self, ... }:
{
  flake.nixosModules.theme-almond-blossoms =
    { pkgs, ... }:
    {
      imports = [ self.nixosModules.theme-common ];
      stylix.image = "${../../../assets/media/wallpapers/almond-blossoms.jpg}";
      stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    };
}
