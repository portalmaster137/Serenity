{ self, inputs, ... }:
let
  name = "serenity";
  home = "/home/${name}";
in
{
  flake.nixosModules.u-serenity =
    { pkgs, ... }:
    {
      modules = [
        self.foo.bar
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            verbose = true;
            useUserPackages = true;
            useGlobalPkgs = true;
            backupFileExtension = "backup";
            overwriteBackup = true;
            users.${name} = {
              imports = [
                self.flake.homeModules.baseHome
              ];
            };
          };
        }

      ];

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
