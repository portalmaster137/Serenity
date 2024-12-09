# # https://nixos.wiki/PipeWire
## https://github.com/musnix/musnix 

{ ... }:

{
  imports = [ ];

  ## Can't remember what this does,
  ## recommended to be enabled though
  security.rtkit.enable = true;

  ## Not using pulse directly
  hardware.pulseaudio.enable = false;

  ## Using pipewire baybee
  services.pipewire = {
    enable = true;
    ## Uncomment if ypu(g.) want to use JACK applications
    #jack.enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };

    ## Low latency config
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

        context.modules = [{
          name = "libpipewire-module-protocol-pulse";
          args = {
            pulse = {
              default.req = "144/48000";
              min.req = "144/48000";
              max.req = "144/48000";
              min.quantum = "144/48000";
              max.quantum = "144/48000";
            };
          };
        }];

      };

    };

  };

  musnix = {

    enable = true;

  };

}
