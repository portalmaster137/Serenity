## https://mynixos.com/home-manager/options/home.file.%3Cname%3E
## https://nix-community.github.io/home-manager/options.xhtml#opt-home.file
## https://nix-community.github.io/home-manager/options.xhtml#opt-home.activation

{ ... }:

{

  # need option for `zfs set mountpoint=/myspecialfolder mypool`

  home = {

    ## Directories to copy to /home/${username/}
    file = {

      ## Path to automount disks to
      "Disks" = {
        source = ../automount/Disks;
        recursive = true;
      };
      ## (current) Flake path
      "flakes/nixdots" = {
        source = ../../../../nixdots;
        recursive = true;
      };
      ## (future) Flake path
      "SerenityOS" = {
        source = ../../../../nixdots;
        recursive = true;
      };

    };

  };

  ## Related services
  services = {

    ## Udiskie
    udiskie = {
      enable = true;
      automount = true; # automounts new disks
      tray = "always";
      notify = true; # enables the tray applet
      #settings = {
      #};
    };

  };

}
