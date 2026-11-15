{ self, ... }:
{
  flake.nixosModules.theme-autogen =
    { ... }:
    {
      imports = [ self.nixosModules.theme-common ];
      stylix.image = "${../../../assets/media/wallpapers/nixos.png}";
    };
}
