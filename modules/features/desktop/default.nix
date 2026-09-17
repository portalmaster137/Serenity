{ self, inputs, ... }:

{

  # desktop supermodule
  flake.nixosModules.desktop = {

    # modules to include
    imports = [

      # session management
      #self.nixosModules.${greeter}

      # window manager
      self.nixosModules.niri

      # application launcher
      self.nixosModules.wofi

      # desktop shell/status bar
      self.nixosModules.noctalia

      # theme management
      #self.nixosModules.stylix

      # for home manager functionality
      inputs.home-manager.nixosModules.home-manager

    ];

  };

}
