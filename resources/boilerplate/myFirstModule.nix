{ inputs, ... }: {

  # module declaration
  flake.nixosModules.myFirstModule = { pkgs, ... }: {

    # options declarations
    programs.firefox.enable = true;

    # packages to include
    environment.systemPackages = with pkgs; [
      helix
    ];

  };

}
