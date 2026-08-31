{ inputs, ... }: {

  # module declaration
  flake.nixosModules.gaming = { pkgs, ... }: {

    # options declarations
    #programs.whatever = {};

    # steam
    programs.steam = { };

    # packages to include
    environment.systemPackages = with pkgs; [ ];

  };

}
