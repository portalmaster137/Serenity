{ self, ... }:
{
  flake.nixosModules.theme-monochrome =
    { lib, user-parts, ... }:
    {
      imports = [ self.nixosModules.theme-common ];
      stylix.image = "${../../../assets/media/wallpapers/attunement.png}";
      home-manager.users.${user-parts.user.username}.stylix.opacity = {
        applications = lib.mkForce 0.9;
        terminal = lib.mkForce 0.9;
      };
    };
}
