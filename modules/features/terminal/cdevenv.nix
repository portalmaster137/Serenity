{ ... }:
{
  flake.nixosModules.cdevenv =
    { pkgs, ... }:
    {

      # onig_sys links against the system Oniguruma library.
      nixpkgs.overlays = [
        (final: prev: {
          neocmakelsp = prev.neocmakelsp.overrideAttrs (old: {
            nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ final.pkg-config ];
            buildInputs = (old.buildInputs or [ ]) ++ [ final.oniguruma ];
          });
        })
      ];

      environment.systemPackages = with pkgs; [
        libclang
        neocmakelsp
        cmake
        gcc
        gnumake
        python3
        uv
      ];
    };
}
