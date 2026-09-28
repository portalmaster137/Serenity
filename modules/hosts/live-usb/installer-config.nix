{ self, inputs, ... }:

{

  # install helper module
  flake.nixosModules.installer =

    { lib, pkgs, ... }:

    {

      # for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # custom calamares
      environment.systemPackages = with pkgs; [
        calamares-nixos
        calamares-nixos-extensions
      ];

      home-manager.users.serenity = {

        home.file."flake-repo" = {
          source = fetchGit {
            url = "https://codeberg.org/serenity-F/SerenityOS.git";
            # sha256 = sha;
          };
          target = "/home/serenity/flake-repo";
          recursive = true;
        };

      };

    };

}
