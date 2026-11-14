{ inputs, ... }:
{
  flake.nixosModules.nixd =
    { pkgs, user-parts, ... }:
    {
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # fnm's zstd-sys dependency needs pkg-config and libzstd at build time.
      nixpkgs.overlays = [
        (final: prev: {
          fnm = prev.fnm.overrideAttrs (old: {
            nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ final.pkg-config ];
            buildInputs = (old.buildInputs or [ ]) ++ [ final.zstd ];
          });
          # The forced system-library hook lacks matching inputs in this package.
          # Keep upstream's bundled libraries until nixpkgs supplies those inputs.
          #codex = prev.codex.overrideAttrs (old: {
          #  dontCargoUseSystemLibs = true;
          #});
        })
      ];

      environment.systemPackages = with pkgs; [
        nixd
        fnm
        #codex
        bubblewrap
      ];
      programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [ icu ];
      };
    };
}
