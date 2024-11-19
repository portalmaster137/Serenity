{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:

{

  imports = [
  ];

  ## Declarative sync directory creation
  systemd.tmpfiles.settings = {
    "hecate" = {
      "/home/serenity/sync/backups/hecate" = {
        d = {
          group = "users";
          mode = "0777";
          user = "serenity";
        };
      };
    };
    "hecate-backups" = {
      "/home/serenity/sync/backups/hecate/backups" = {
        d = {
          group = "users";
          mode = "0777";
          user = "serenity";
        };
      };
    };
    "hecate-pictures" = {
      "/home/serenity/sync/backups/hecate/pictures" = {
        d = {
          group = "users";
          mode = "0777";
          user = "serenity";
        };
      };
    };
    "hecate-misc" = {
      "/home/serenity/sync/backups/hecate/misc" = {
        d = {
          group = "users";
          mode = "0777";
          user = "serenity";
        };
      };
    };
  };

}
