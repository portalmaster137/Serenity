{ inputs, pkgs, config, user, ... }:

  # https://nixos.wiki/wiki/VR

{

  # Enables Monado an OpenXR runtime
  # https://monado.freedesktop.org/
  services.monado = {
    enable = true;
    defaultRuntime = true; # Set OpenXR runtime
  };

  # For further information about available environment variables and tweaks,
  # read the Linux VR Adventures wiki and the Monado documentation about environment variables
  # https://lvra.gitlab.io/docs/fossvr/monado/
  # https://monado.freedesktop.org/getting-started.html#environment-variables
  systemd.user.services.monado.environment = {
    STEAMVR_LH_ENABLE = "1"; # For SteamVR
    XRT_COMPOSITOR_COMPUTE = "1";
  };

  ## ## ## ## ## ## ## ## ## ## ## ##
  # OpenComposite VR compatibility layer
  # https://gitlab.com/znixian/OpenOVR
  # Place this somewhere in flake home level, E.g.
  # ~/SerenityOS/home/desktop/virtualReality.nix
  # An example configuration for enabling OpenComposite may look like this: 
  xdg.configFile."openvr/openvrpaths.vrpath".text = ''
    {
      "config" :
      [
        "${config.xdg.dataHome}/Steam/config"
      ],
      "external_drivers" : null,
      "jsonid" : "vrpathreg",
      "log" :
      [
        "${config.xdg.dataHome}/Steam/logs"
      ],
      "runtime" :
      [
        "${pkgs.opencomposite}/lib/opencomposite"
      ],
      "version" : 1
    }
  '';
  # If you are planning to play any OpenVR game on Steam or OpenXR games through Proton,
  # you will have to use OpenComposite in this manner. In most cases you also have to allow
  # access to the socket path of your OpenXR runtime to Steam's runtime, by using the following
  # launch options for XR applications on Steam:
  #   `env PRESSURE_VESSEL_FILESYSTEMS_RW=$XDG_RUNTIME_DIR/monado_comp_ipc %command%`
  # This example is for Monado, while other XR runtimes might differ. 
  ## ## ## ## ## ## ## ## ## ## ## ##
}
