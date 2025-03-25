# # https://mynixos.com/home-manager/options/home.file.%3Cname%3E
## https://nix-community.github.io/home-manager/options.xhtml#opt-home.file
## https://nix-community.github.io/home-manager/options.xhtml#opt-home.activation

{ config, flakePath, disksPath, primaryUser, ... }:

{

  # need option for `zfs set mountpoint=/myspecialfolder mypool`
  # need to set up auto luks unlock with sops-nix

  ## Provides LUKS key for Asphodel
  environment.etc."crypttab".text = ''
    data /dev/disk/by-uuid/45f5f6ad-a676-4bc1-ad4b-e3e26b5697f4 ${config.sops.secrets.Asphodel-key.path}
  '';
  ## Mounts Asphodel to typical media location
  fileSystems."/run/media/${primaryUser}/Asphodel".device =
    "/dev/mapper/Asphodel";

  home = {

    ## Directories to copy to /home/${username/}
    file = {

      ## Path to automount disks to
      #"Disks" = {
      #source = ./Disks;
      #target = "${disksPath}";
      #recursive = true;
      #};

      ## (current) Flake path
      #"flakes/nixdots" = {
      #source = ../../../../nixdots;
      #recursive = true;
      #};

      ## (future) Flake path
      #"SerenityOS" = {
      #source = ./SerenityOS;
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
