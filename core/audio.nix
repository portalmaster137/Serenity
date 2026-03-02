## https://nixos.wiki/wiki/Category:Audio
## https://nixos.wiki/PipeWire
## https://github.com/musnix/musnix
## https://nixos.wiki/wiki/Audio_production

{ pkgs, ... }:

{

  ## SHOULD BE ELSEWHERE - temporary testing declarations
  environment.systemPackages = with pkgs; [
    helm
    vital
  ];

  boot = {
    kernelModules = [ "snd-seq" "snd-rawmidi" ];
    kernelParams = [ "preempt=full" ];
  };

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

  # Musnix for audio production
  musnix = {
    enable = true;
    rtcqs.enable = true;
    rtirq.enable = true;
    kernel.realtime = true;
  };

  # Pipewire baybee
  services = {

    # Not using pulse directly
    pulseaudio = { enable = false; };

    pipewire = {
      enable = true;
      jack.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };

      # Low latency config
      extraConfig = {
        pipewire."92-low-latency" = {
          "context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.allowed-rates" = [ 44100 48000 96000 192000 ];
            "default.clock.quantum" = 256;
            "default.clock.min-quantum" = 256;
            "default.clock.max-quantum" = 384;
          };
        };
        pipewire-pulse."92-low-latency" = {
          stream.properties = {
            node.latency = "256/48000";
            resample.quality = 1;
          };
          context.modules = [{
            name = "libpipewire-module-protocol-pulse";
            ## Apparently I need to have the full key 'pulse.foo.bar = "foobar/foo";' declared,
            ## rather than declaring 'foo.bar = "foorbar/foo";' inside a nested 'pulse = { };' set.
            ## See: https://discourse.nixos.org/t/setting-up-pipewire-to-get-rid-of-cracks-noises
            args = {
              pulse.min.req = "256/48000";
              pulse.max.req = "256/48000";
              pulse.default.req = "256/48000";
              pulse.min.quantum = "256/48000";
              pulse.max.quantum = "384/48000";
            };
          }];

        };

      };

    };
  };

}
