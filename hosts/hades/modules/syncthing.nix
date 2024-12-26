{ pkgs, primaryUser, ... }:

{

  environment = {
    systemPackages = with pkgs; [ syncthing syncthing-cli syncthing-tray ];
  };

  services = {

    syncthing = {
      enable = true;
      #configDir = path;
      dataDir = "/home/${primaryUser}/sync";
      #overrideDevices = true;
      #overrideFolder = true;

      ## these 3 devices are pretty much my entire ecosystem for now
      #settings.devices = {
        #hades.id = "DEVICE_ID";
        #proserpina.id = "DEVICE_ID";
        #hecate.id = "DEVICE_ID";
      };

      ## plan to have this dir automatically committed and pushed to a git repo daily
      #settings.folders = {
        #"FOLDER_ID" = {
        #path = "/home/${primaryUser}/Sync/Notes";
        #devices = [ "hecate" "hades" "persephone" ];
        #};

        #"FOLDER_ID" = {
        #path = "/home/${primaryUser}/Sync/Keyring";
        #devices = [ "hecate" "hades" "persephone" ];
        #};

      };
    };

  };

}
