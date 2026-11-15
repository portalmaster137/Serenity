{ self, ... }:
{
  flake.nixosModules.theme-tokyo-night =
    { pkgs, ... }:
    {
      imports = [ self.nixosModules.theme-common ];
      stylix.image = "${../../../assets/media/wallpapers/mima-kirigoe.jpg}";
      stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-terminal-dark.yaml";
    };
}
