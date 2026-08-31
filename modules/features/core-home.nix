{ self, inputs, ... }: {

  flake.homeModules.core-home = { config, pkgs, ... }: {

    #modules = [
    #self.modules.terminal
    #self.modules.theme
    #];

    imports = [
      #./terminal
      self.modules.terminal
      self.modules.desktop
      #self.modules.theme
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
