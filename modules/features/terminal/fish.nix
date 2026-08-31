{ self, inputs, ... }: {

  flake.modules.homeManager.fish = {

    # defines a custom fish package
    home.packages = with pkgs; [
      fish
    ];

    programs = {

      # starship prompt
      starship = {
        enable = true;
        settings = { };
      };

      # fish shell
      fish = {
        enable = true;
        settings = { };
      };

    };

  };

}
