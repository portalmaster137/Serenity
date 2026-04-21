## https://nixos.wiki/wiki/Category:Audio
## https://nixos.wiki/PipeWire
## https://github.com/musnix/musnix
## https://nixos.wiki/wiki/Audio_production

{ user, ... }:

{

  # Permissions & Security
  security.rtkit.enable = true;
  users.users.${user}.extraGroups = [ "audio" ]; # adds user to audio group
  services.udev = { # needed for security
    extraRules = ''
      KERNEL=="rtc0", GROUP="audio"
      KERNEL=="hpet", GROUP="audio"
    '';
  };

  # Available kernel modules
  boot = {
    kernelModules = [ "snd-seq" "snd-rawmidi" ];
    kernelParams = [ "preempt=full" ];
  };

  # realtime audio priority (initially for JACK2)
  security.pam.loginLimits = [
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

  # Musnix for audio production
  musnix = {
    enable = true;
    rtcqs.enable = true;
    rtirq.enable = true;
    kernel.realtime = true;
  };

  # Pipewire baybee
  services = {
    pulseaudio = { enable = false; }; # not directly using pulse 
    pipewire = {
      enable = true; # enables pipewire
      alsa = {
        enable = true; # enables alsa through pipewire
        support32Bit = true; # enables 32bit application support
      };
      jack.enable = true; # enables jack through pipewire
      pulse.enable = true; # enables pulse through pipewire
      wireplumber.enable = true; # enables wireplumber
      extraConfig = { 
        # Low latency optimisations
        pipewire."92-low-latency" = { # for pipewire
          "context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.allowed-rates" = [ 44100 48000 96000 192000 ];
            "default.clock.quantum" = 256;
            "default.clock.min-quantum" = 256;
            "default.clock.max-quantum" = 384;
          };
        };
        pipewire-pulse."92-low-latency" = { # for pulseaudio
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
