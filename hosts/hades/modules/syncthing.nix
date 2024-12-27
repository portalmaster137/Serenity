{ pkgs, primaryUser, homeDir, ... }:

{

  environment = {
    systemPackages = with pkgs; [
      syncthing # standard syncthing package
      syncthing-tray # tray applet for syncthing
    ];
  };

  systemd.services = {
    syncthing = {
      environment.STNODEFAULTFOLDER = "true"; # prevents the `Sync` folder from being created on activation
    };
  };

  services = {
    syncthing = {
      enable = true; # easy toggle
      dataDir = "${homeDir}"; # defaults to primaryUser's homedir
      openDefaultPorts = true; # opens the default firewall ports
      configDir = "${homeDir}/.config/syncthing"; # defaults to primaryUser's homedir
      user = "${primaryUser}"; # uses primaryUser to run the service
      group = "users"; # runs in the users group
      guiAddress = "0.0.0.0:8384"; # default web address for the GUI
      settings = {

        ## Syncthing Folders
        overrideFolders = true; # force these folder on activation
        folders = {

          "Keyring" = { # folder for password/secrets vault
            enable = false; # easy toggle - OFF for now
            path = "${homeDir}/Keyring"; # defaults to primaryUser's homedir
            #devices = [ ]; # left empty for now
            versioning = { # versioning, for redundancy
              type = "simple"; # nothing fancy, keeps x number of copies
              params = { keep = "3"; }; # number of copies to keep
            };
          };

          "Notes" = { # folder for organisation/notes vault
            enable = true; # easy toggle
            path = "${homeDir}/Notes"; # defaults to primaryUser's homedir
            #devices = [ ]; # left empty for now
            versioning = { # versioning, for redundancy
              type = "simple"; # nothing fancy, keeps x number of copies
              params = { keep = "3"; }; # number of copies to keep
            };
          };

        };

        ## Syncthing Devices
        overrideDevices = true; # force these devices on activation
        devices = { # all syncthing devices listed - 'boilerplate' for other hosts

          #"Orcus".id = "REALLY-LONG-ORCUS-SYNCTHING-KEY-HERE"; # disabled for testing
          #"Hades".id = "REALLY-LONG-HADES-SYNCTHING-KEY-HERE"; # disabled for testing
          "Hecate".id = "36WUSM4-HFYOGWP-33JHBPI-WR2TXXE-ZX3PFMB-QH6BMXM-DQ523ZF-FD7M3AI";
          #"Persephone".id = "REALLY-LONG-PERSEPHONE-SYNCTHING-KEY-HERE"; # disabled for testing

        };
      };
    };
  };

}
