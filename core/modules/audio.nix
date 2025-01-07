## https://nixos.wiki/wiki/Category:Audio
## https://nixos.wiki/PipeWire
## https://github.com/musnix/musnix
## https://nixos.wiki/wiki/Audio_production

{

  #boot.kernelModules = [ "snd-seq" "snd-rawmidi" ];

  ## Can't remember what this does,
  ## recommended to be enabled though
  security = {
    rtkit.enable = true;
    # realtime audio priority (initially for JACK2)
    pam.loginLimits = [
      {
        domain = "@audio";
        item = "memlock";
        type = "-";
        value = "unlimited";
      }
      {
        domain = "@audio";
        item = "rtprio";
        type = "-";
        value = "99";
      }
      {
        domain = "@audio";
        item = "nofile";
        type = "soft";
        value = "99999";
      }
      {
        domain = "@audio";
        item = "nofile";
        type = "hard";
        value = "99999";
      }
    ];
  };

  services.udev = {
    extraRules = ''
      KERNEL=="rtc0", GROUP="audio"
      KERNEL=="hpet", GROUP="audio"
    '';
  };

  ## Not using pulse directly
  hardware.pulseaudio.enable = false;

  ## Musnix for audio production
  musnix = {
    enable = true;
    rtcqs.enable = true;
    rtirq.enable = true;
    kernel.realtime = true;
  };

  ## Using pipewire baybee
  services = {

    pulseaudio.enable = false;

    pipewire = {
      enable = true;
      jack.enable = true;
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
            "default.clock.quantum" = 150;
            "default.clock.min-quantum" = 150;
            "default.clock.max-quantum" = 150;
          };
        };

        pipewire-pulse."92-low-latency" = {
          stream.properties = {
            node.latency = "150/48000";
            resample.quality = 1;
          };

          context.modules = [{
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse = {
                default.req = "150/48000";
                min.req = "150/48000";
                max.req = "150/48000";
                min.quantum = "150/48000";
                max.quantum = "150/48000";
              };
            };
          }];

        };

      };

    };
  };

}
