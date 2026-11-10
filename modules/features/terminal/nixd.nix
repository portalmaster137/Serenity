{ inputs, ... }:
{
  flake.nixosModules.nixd =
    { pkgs, user-parts, ... }:
    {
      imports = [ inputs.home-manager.nixosModules.home-manager ];
      environment.systemPackages = with pkgs; [
        nixd
        fnm
        codex
        bubblewrap
      ];
      programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [ icu ];
      };
    };
}
