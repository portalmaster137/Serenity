{ self, inputs, ... }:
let
  name = "serenity";
  home = "/home/${name}";
in
{
  flake.modules.nixos.user =
    { pkgs, ... }:
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ];

      home-manager = {
        verbose = true;
        useUserPackages = true;
        useGlobalPkgs = true;
        backupFileExtension = "backup";
        overwriteBackup = true;

        users.${name} = {
          imports = with self.modules.homeManager; [
            {
              home = {
                username = name;
                homeDirectory = home;
                stateVersion = "26.05";
              };
            }
            kitty
          ];
        };
      };

      users.users.${name} = {
        isNormalUser = true;
        initialPassword = "password";
        inherit home;
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
        shell = pkgs.fish; # TODO: Don't hardcode this.
      };
    };
}
