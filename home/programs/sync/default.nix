# # https://mynixos.com/home-manager/options/home.file.%3Cname%3E
## https://nix-community.github.io/home-manager/options.xhtml#opt-home.file
## https://nix-community.github.io/home-manager/options.xhtml#opt-home.activation

{ inputs, outputs, pkgs, config, flakePath, disksPath, user, ... }:

{

  imports = [ # inputs.sops-nix.nixosModules.sops
  ];

  # need option for `zfs set mountpoint=/myspecialfolder mypool`
  # need to set up auto luks unlock with sops-nix

  ## Provides LUKS key for Asphodel
  #environment.etc."crypttab".text = ''
  #Asphodel /dev/disk/by-uuid/45f5f6ad-a676-4bc1-ad4b-e3e26b5697f4 ${config.sops.secrets.asphodelLuksPassword}
  #'';

  ## Mounts Asphodel to typical media location
  #fileSystems."/run/media/${user}/Asphodel".device =
  #"/dev/mapper/Asphodel";

  #home.file = { # Files and directories to copy to ${homeDir}

  ## Example format for home.file
  #"Foo" = { # Name for the copied file
  #source = ./Foo; # Source is relative to this file
  #target = "Desired/Path/To/Foo"; # Target path for Foo within ${homeDirectory}
  #recursive = true; # Unsure if necessary for most things
  #};

  #};

  ## Related services
  services = {

    ## Udiskie/automount program
    udiskie = {
      enable = true;
      automount = true; # automounts newly registered disks
      notify = true; # sends a notification on disk mount
      tray = "auto"; # enables the tray applet only when a device is available
      #settings = {
      #};
    };

    ## Syncthing program service
    #syncthing = {
    #enable = false;
    #tray.enable = true;
    #guiAddress = "home.syncthing:8384";
    #};

  };

}
