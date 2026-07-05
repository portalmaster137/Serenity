{ pkgs, ... }:
{
  users.users.serenity = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "i2c"
      "input"
      "libvirtd"
      "networkmanager"
      "plugdev"
      "transmission"
      "video"
      "wheel"
    ];
  };
}
