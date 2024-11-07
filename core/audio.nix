## https://nixos.wiki/PipeWire
## https://github.com/musnix/musnix 

{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
     #./file.nix
  ];

  security.rtkit.enable = true;

  hardware.pulseaudio.enable = false;

  services.pipewire = {  
    enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    ## If you(g.) want to use JACK applications, uncomment this.
     #jack.enable = true;
    extraConfig = {

      pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 72;
          "default.clock.min-quantum" = 72;
          "default.clock.max-quantum" = 72;
        };
      };

      pipewire-pulse."92-low-latency" = {
        context.modules = [ {
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse.min.req = "72/48000";
              pulse.default.req = "72/48000";
              pulse.max.req = "72/48000";
              pulse.min.quantum = "72/48000";
              pulse.max.quantum = "72/48000";
            };
        } ];
        stream.properties = {
          node.latency = "72/48000";
          resample.quality = 1;
        };
      };

    };
  };

}
