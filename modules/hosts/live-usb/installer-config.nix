{ self, inputs, ... }:

{

  flake.nixosModules.installer =

    { lib, pkgs, ... }:

    {

      environment.systemPackages = with pkgs; [
        calamares
        calamares-nixos
        calamares-nixos-extensions
      ];
    };

}
