## https://mynixos.com/home-manager/options/home.file.%3Cname%3E
## https://nix-community.github.io/home-manager/options.xhtml#opt-home.file
## https://nix-community.github.io/home-manager/options.xhtml#opt-home.activation

{ ... }:

{

  ## need option for `zfs set mountpoint=/myspecialfolder mypool`

  home.file."Disks" = {
    source = ../automount/Disks;
    recursive = true;
  };

  services = {
    udiskie = {
      enable = true;
      automount = true;
      tray = "always";
      notify = true;
      #settings = {
      #};
    };
  };

}
