{ self, inputs, ... }:
let
  name = "serenity";
  home = "/home/${name}";
in
{
  flake.nixosModules.u-serenity =
    { pkgs, ... }:
    {
      imports = [
        self.homeModules.baseHome
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
