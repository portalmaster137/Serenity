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

   #sound.enable = false;
  hardware.pulseaudio.enable = false;

  services.pipewire = {  
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    jack = {
      enable = false;
    };
    pulse = {
      enable = true;
    };
    extraConfig = {

      pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 32;
          "default.clock.min-quantum" = 32;
          "default.clock.max-quantum" = 32;
        };
      };

      pipewire-pulse."92-low-latency" = {
        context.modules = [ {
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse.min.req = "32/48000";
              pulse.default.req = "32/48000";
              pulse.max.req = "32/48000";
              pulse.min.quantum = "32/48000";
              pulse.max.quantum = "32/48000";
            };
        } ];
        stream.properties = {
          node.latency = "32/48000";
          resample.quality = 1;
        };
      };

    };
  };

}
