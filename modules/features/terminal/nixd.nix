{ ... }:
{
  flake.nixosModules.nixd =
    { pkgs, ... }:
    {

      # fnm's zstd-sys dependency needs pkg-config and libzstd at build time.
      nixpkgs.overlays = [
        (final: prev: {
          fnm = prev.fnm.overrideAttrs (old: {
            nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ final.pkg-config ];
            buildInputs = (old.buildInputs or [ ]) ++ [ final.zstd ];
          });
        })
      ];

      environment.systemPackages = with pkgs; [
        nixd
        fnm
        bubblewrap
      ];
      programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [ icu ];
      };
    };
}
