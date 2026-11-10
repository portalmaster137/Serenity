{ inputs, ... }:

{
  flake.nixosModules.cream-installer =
    { config, lib, pkgs, ... }:
    let
      creamlinux = import inputs.creamlinux-installer { inherit pkgs; };
    in
    {
      environment.systemPackages = [
        (creamlinux.overrideAttrs (old: {
          # Upstream's WebKit workaround is required on NVIDIA GPUs.
          preFixup = (old.preFixup or "") + lib.optionalString
            (builtins.elem "nvidia" config.services.xserver.videoDrivers)
            ''
              gappsWrapperArgs+=(--set WEBKIT_DISABLE_DMABUF_RENDERER 1)
            '';
        }))
      ];
    };
}
