{ self, inputs, ... }:

{

  # general music module declaration
  flake.nixosModules.music =

    { pkgs, user-parts, ... }:

    {

      # for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      home-manager.users.${user-parts.user.username} = {

        # audio effects
        services.easyeffects.enable = true;

        # music daemon
        services.mpd = {
          enable = true;
          musicDirectory = /run/media/${user-parts.user.username}/Orcus/media-share/Music;
        };

        # mpris for music daemon
        services.mpdris2 = {
          enable = true;
        };

        # mpris for music daemon
        #services.mpd-mpris = { enable = true; };

        # music player
        programs.rmpc = {
          enable = true;
        };

        home.packages = with pkgs; [

          # players
          spotify # corporate garbage
          lollypop # offline music player
          strawberry # offline music player

          # misc
          audacity # audio editing
          puddletag # file tagger

        ];

      };

    };

  # music production module declaration
  flake.nixosModules.music-production =

    { pkgs, user-parts, ... }:

    {

      imports = [

        # for home manager functionality
        inputs.home-manager.nixosModules.home-manager

        # for realtime audio production and enhancements
        inputs.musnix.nixosModules.musnix

      ];

      # kernel tweaks
      # boot = {
      #   kernelModules = [
      #     "snd-seq"
      #     "snd-rawmidi"
      #   ];
      #   kernelParams = [
      #     "threadirqs"
      #     "preempt=full"
      #     "usbcore.autosuspend=-1"
      #   ];
      # };

      # needed for realtime audio
      security.rtkit.enable = true;

      # adds user to necessary groups
      users.users.${user-parts.user.username}.extraGroups = [ "audio" ];

      # musnix itself
      musnix = {
        enable = true;
      };

      # needed for security
      # services.udev = {
      #   extraRules = ''
      #     KERNEL=="rtc0", GROUP="audio"
      #     KERNEL=="hpet", GROUP="audio"
      #   '';
      # };

      # realtime audio priority (initially for JACK2)
      # security.pam.loginLimits = [
      #   {
      #     domain = "@audio";
      #     item = "memlock";
      #     type = "-";
      #     value = "unlimited";
      #   }
      #   {
      #     domain = "@audio";
      #     item = "rtprio";
      #     type = "-";
      #     value = "99";
      #   }
      #   {
      #     domain = "@audio";
      #     item = "nofile";
      #     type = "soft";
      #     value = "99999";
      #   }
      #   {
      #     domain = "@audio";
      #     item = "nofile";
      #     type = "hard";
      #     value = "99999";
      #   }
      # ];

      # user level options
      home-manager.users.${user-parts.user.username} = {
        home.packages = with pkgs; [ ];
      };

      environment = {

        # system level packages for music production
        systemPackages = with pkgs; [

          # daws
          bespokesynth # modular synth emulator
          vcv-rack # modular synth emulator

          # vsts
          vital
          helm

          # other

        ];

        # Use environment variables for reliable access to vsts
        # variables =
        #   let
        #     makePluginPath =
        #       format:
        #       (pkgs.lib.makeSearchPath format [
        #         "$HOME/.nix-profile/lib"
        #         "/run/current-system/sw/lib"
        #         "/etc/profiles/per-user/$USER/lib"
        #       ])
        #       + ":$HOME/.${format}";
        #   in
        #   {
        #     LV2_PATH = makePluginPath "lv2";
        #     VST3_PATH = makePluginPath "vst3";
        #     CLAP_PATH = makePluginPath "clap";
        #   };
      };

      # pipewire baybee
      services = {
        pulseaudio.enable = false; # not directly using pulse
        pipewire = {
          enable = true; # enables pipewire
          alsa = {
            enable = true; # enables alsa through pipewire
            support32Bit = true; # enables 32bit application support
          };
          jack.enable = true; # enables jack through pipewire
          pulse.enable = true; # enables pulse through pipewire
          wireplumber = {
            enable = true; # enables wireplumber
            extraConfig."99-disable-suspend" = {
              "monitor.alsa.rules" = [
                {
                  matches = [
                    { "node.name" = "~alsa_input.*"; }
                    { "node.name" = "~alsa_output.*"; }
                  ];
                  actions = {
                    update-props = {
                      "session.suspend-timeout-seconds" = 0;
                    };
                  };
                }
              ];
            };
          };
          extraConfig = {
            # low latency optimisations
            pipewire."92-low-latency" = {
              # for pipewire
              "context.properties" = {
                "default.clock.rate" = 44100;
                "default.clock.quantum" = 128;
                "default.clock.min-quantum" = 32;
                "default.clock.max-quantum" = 512;
              };
            };
            pipewire-pulse."92-low-latency" = {
              # for pulseaudio
              stream.properties = {
                node.latency = "128/44100";
                resample.quality = 1;
              };
              context.modules = [
                {
                  name = "libpipewire-module-protocol-pulse";
                  # apparently I need to have the full key 'pulse.foo.bar = "foobar/foo";' declared,
                  # rather than declaring 'foo.bar = "foorbar/foo";' inside a nested 'pulse = { };' set.
                  # see: https://discourse.nixos.org/t/setting-up-pipewire-to-get-rid-of-cracks-noises
                  args = {
                    pulse.min.req = "128/44100";
                    pulse.max.req = "128/44100";
                    pulse.default.req = "128/44100";
                    pulse.min.quantum = "32/44100";
                    pulse.max.quantum = "512/44100";
                  };
                }
              ];
            };
          };
        };
      };

    };

}
