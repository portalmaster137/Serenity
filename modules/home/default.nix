{ self, inputs, ... }: {

  flake.homeModules.baseHome = { config, pkgs, ... }: {

    imports = [
      ./terminal
      self.modules.theme
    ];

    home = {
      username = "serenity";
      homeDirectory = "/home/serenity";
      stateVersion = "26.05";
      #extraOutputsToInstall = [ ];
    };

    # disable manuals as nmd fails to build often
    manual = {
      html.enable = false;
      json.enable = false;
      manpages.enable = false;
    };

    # let HM manage itself when in standalone mode
    programs.home-manager.enable = true;
  };
}
