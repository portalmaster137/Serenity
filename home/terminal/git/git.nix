{ pkgs, config, ... }:

{
  programs.git = {
    # Enable git with home-manager
    enable = true;
    settings = {
      user = {
        # User details
        name = "serenity-F";
        email = "serenity-F@noreply.codeberg.org";
        # Path to user signing key
        signingKey = "/home/serenity/.ssh/id_ed25519.pub";
      };

      # Use SSH keys for auth
      gpg.format = "ssh";
      commit.gpgSign = true;

      # Use "main" as default branch
      init.defaultBranch = "main";
      # Automatically track remote branch
      push.autoSetupRemote = true;

    };

    ## OLD SETTINGS
    #userName = "serenity-F";
    #userEmail = "serenity-F@noreply.codeberg.org";
    #extraConfig = {
      #init.defaultBranch = "main";
      #gpg.format = "ssh";
      #commit.gpgSign = true;
      #user.signingKey = "/home/serenity/.ssh/id_ed25519.pub";
      #push.autoSetupRemote = true;
    #};
  };
}
