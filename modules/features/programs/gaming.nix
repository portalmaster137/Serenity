{ inputs, ... }: {

  # gaming module declaration
  flake.nixosModules.gaming = { inputs, pkgs, ... }: {

    # options declarations
    #programs.whatever = {};

    # steam settings
    programs.steam = {

      # enables steam
      enable = true;

    };

    # other packages to include
    environment.systemPackages = with pkgs; [ ];

  };

}
