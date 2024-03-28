let
  gnomeProfile = import ../../profiles/gnome.nix;
in
{
  imports = [
    ../../home.nix
  ];
  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = gnomeProfile.extensions.laptop;
      # favorite-apps = gnomeProfile.pinnedApps.laptop;
    };
  };
}
