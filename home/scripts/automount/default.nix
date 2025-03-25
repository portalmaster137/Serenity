# # https://mynixos.com/home-manager/options/home.file.%3Cname%3E
## https://nix-community.github.io/home-manager/options.xhtml#opt-home.file
## https://nix-community.github.io/home-manager/options.xhtml#opt-home.activation

{ flakePath, disksPath, ... }:

{

  # need option for `zfs set mountpoint=/myspecialfolder mypool`

  home = {

    ## Directories to copy to /home/${username/}
    file = {

      ## Path to automount disks to
      "Disks" = {
        source = ./Disks;
        target = "${disksPath}";
        recursive = false;
      };

      ## (current) Flake path
      #"flakes/nixdots" = {
      #source = ../../../../nixdots;
      #recursive = true;
      #};

      ## (future) Flake path
      #"SerenityOS" = {
      #source = ../../../../nixdots;
      #target = "${flakePath}";
      #recursive = true;
      #};

    };

  };

  ## Related services
  services = {

    ## Udiskie/automount program
    udiskie = {
      enable = true;
      automount = true; # automounts newly registered disks
      notify = true; # sends a notification on disk mount
      tray = "always"; # enables the tray applet
      #settings = {
      #};
    };

  };

}
