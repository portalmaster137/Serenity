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
  ];

  security.rtkit.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {  
    enable = true;
    ## Uncomment if ypu(g.) want to use JACK applications
     #jack.enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    extraConfig = {

      pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 144;
          "default.clock.min-quantum" = 144;
          "default.clock.max-quantum" = 144;
        };
      };

      pipewire-pulse."92-low-latency" = {
        stream.properties = {
          node.latency = "144/48000";
          resample.quality = 1;
        };
        context.modules = [ {
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse.min.req = "144/48000";
              pulse.default.req = "144/48000";
              pulse.max.req = "144/48000";
              pulse.min.quantum = "144/48000";
              pulse.max.quantum = "144/48000";
            };
        } ];
      };

    };

  };

}
