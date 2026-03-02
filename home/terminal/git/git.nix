{ pkgs, config, user, homeDirectory, ... }:

{
  programs.git = {
    enable = true;
    userName = "serenity-F";
    userEmail = "serenity-F@noreply.codeberg.org";
    extraConfig = {
      init.defaultBranch = "main";
      # Automatically track remote branch
      gpg.format = "ssh";
      commit.gpgSign = true;
      user.signingKey = "/home/serenity/.ssh/id_ed25519.pub";
      push.autoSetupRemote = true;
    };
  };
}
