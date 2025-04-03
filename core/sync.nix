# https://github.com/gitwatch/gitwatch
# https://nixos.wiki/wiki/Syncthing
{ pkgs, primaryUser, homeDir, ... }:

{

  environment = {
    systemPackages = with pkgs; [
      gitwatch # automatic git versioning
      syncthing # standard syncthing package
      #syncthing-tray # tray applet for syncthing
    ];
  };

  services = {

    ## Gitwatch
    gitwatch = {

      Keyring = { # keyring backup, dont have a nextcloud (yet)
        enable = true;
        user = "${primaryUser}";
        path = "${homeDir}/Keyring/";
        remote = "git@codeberg.org:serenity-F/keyring.git";
      };

      Notes = { # notes backup, not paying for obsidian backup (lol)
        enable = true;
        user = "${primaryUser}";
        path = "${homeDir}/Notes/";
        remote = "git@codeberg.org:serenity-F/notes.git";
      };
    };

    ## Syncthing
    syncthing = {
      enable = false; # easy toggle
      dataDir = "${homeDir}"; # defaults to primaryUser's homedir
      openDefaultPorts = true; # opens the default firewall ports
      #configDir = "${homeDir}/.config/syncthing"; # defaults to primaryUser's homedir
      user = "${primaryUser}"; # uses primaryUser to run the service
      group = "users"; # runs in the users group
      ## For some reason is using `localhost:8384`
      #guiAddress = "home.syncthing:8384"; # default web address for the GUI
      settings = {
        ## WebApp GUI 
        #user = "serenity";
        #password = "password";

        ## Syncthing Folders
        overrideFolders = true; # force these folder on activation
        folders = {

          "Keyring" = { # folder for password/secrets vault
            enable = true; # easy toggle - OFF for now
            id = "k158k-hvzk3";
            path = "${homeDir}/Keyring"; # defaults to primaryUser's homedir
            devices = [
              #"Hecate"
              #"Persephone"
            ];
            #versioning = { # versioning, for added redundancy
            # disabled for now as we have versioning through git
            #type = "simple"; # nothing fancy, keeps x number of copies
            #params = { keep = "3"; }; # number of copies to keep
            #};
          };

          "Notes" = { # folder for organisation/notes vault
            enable = true; # easy toggle
            id = "h0ay3-l8snk";
            path = "${homeDir}/Notes"; # defaults to primaryUser's homedir
            devices = [
              #"Hecate"
              #"Persephone"
            ];
            #versioning = { # versioning, for added redundancy
            # disabled for now as we have versioning through git
            #type = "simple"; # nothing fancy, keeps x number of copies
            #params = { keep = "3"; }; # number of copies to keep
            #};
          };

        };

        ## Syncthing Devices
        #overrideDevices = true; # force these devices on activation
        #devices = #{ # all syncthing devices listed - 'boilerplate' for other hosts
        #"Orcus".id = "REALLY-LONG-ORCUS-SYNCTHING-KEY-HERE"; # disabled for testing
        #"Hades".id =
        #"L2XWTY6-ATLIQM4-WVRA5JO-Y7RREI5-FBYSOQM-XB3WA4I-F2VHDKG-B2YPJAY";
        #"Hecate".id =
        #"36WUSM4-HFYOGWP-33JHBPI-WR2TXXE-ZX3PFMB-QH6BMXM-DQ523ZF-FD7M3AI";
        #"Persephone".id = "REALLY-LONG-PERSEPHONE-SYNCTHING-KEY-HERE"; # disabled for testing
        #};
      };
    };
  };

  #systemd.services.syncthing = {
  #environment.STNODEFAULTFOLDER = "true";
  # - prevents the `Sync` folder from being created
  #};

}
