let
  gnomeProfile = import ../../desktops/gnome/profiles/gnome-profile.nix;
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
