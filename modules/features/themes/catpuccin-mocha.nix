{ self, ... }:
{
  flake.nixosModules.theme-catpuccin =
    { pkgs, ... }:
    {
      imports = [ self.nixosModules.theme-common ];
      stylix.image = "${../../../assets/media/wallpapers/leaves.png}";
      stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    };
}
