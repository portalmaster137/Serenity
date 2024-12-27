# https://github.com/gitwatch/gitwatch
{ primaryUser, homeDir, ... }:

{

  services.gitwatch.Keyring = {
    enable = false;
    user = "${primaryUser}";
    path = "${homeDir}/Keyring/";
    remote = "git@codeberg.org:serenity-F/keyring.git";
  };

  services.gitwatch.Notes = {
    enable = false;
    user = "${primaryUser}";
    path = "${homeDir}/Notes/";
    remote = "git@codeberg.org:serenity-F/notes.git";
  };

}
