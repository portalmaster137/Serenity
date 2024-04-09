{
  programs.git = {
    enable = true;
    userName = "serenity-F";
    userEmail = "serenity-F@noreply.codeberg.org";
    extraConfig = {
      init.defaultBranch = "main";
      # Automatically track remote branch
      push.autoSetupRemote = true;
    };
  };
}
