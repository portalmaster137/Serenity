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
    "library" = {
      "/home/serenity/sync/library" = {
        d = {
          group = "users";
          mode = "0777";
          user = "serenity";
        };
      };
    };
    "auth" = {
      "/home/serenity/sync/organisation/auth" = {
        d = {
          group = "users";
          mode = "0777";
          user = "serenity";
        };
      };
    };
    "notes" = {
      "/home/serenity/sync/organisation/notes" = {
        d = {
          group = "users";
          mode = "0777";
          user = "serenity";
        };
      };
    };
    "planner" = {
      "/home/serenity/sync/organisation/planner" = {
        d = {
          group = "users";
          mode = "0777";
          user = "serenity";
        };
      };
    };
    "paperwork" = {
      "/home/serenity/sync/organisation/paperwork" = {
        d = {
          group = "users";
          mode = "0777";
          user = "serenity";
        };
      };
    };
  };

}
