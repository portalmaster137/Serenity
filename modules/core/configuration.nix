{ pkgs, lib, ... }:
{

  imports = [
  ./services.nix
  ./display.nix
  ./home.nix
  ./packages
  ];


  # Timezone & locale
  time.timeZone = "Australia/Brisbane";
  i18n.defaultLocale = "en_GB.UTF-8";

  # security, apparently
  security = {
    rtkit.enable = true;
    sudo.execWheelOnly = true;
    pam.services.swaylock = { };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
  
}
