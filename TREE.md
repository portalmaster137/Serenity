[.](https://codeberg.org/serenity-F/nixdots)
├── [README.md](./README.md)
├── [TREE.md](./TREE.md)
├── [flake.nix](./flake.nix]
├── [core](./core)
│   ├── [config.nix](./core/config.nix)
│   ├── [packages.nix](./core/packages.nix)
│   ├── [display.nix](./core/display.nix)
│   ├── [gaming.nix](./core/gaming.nix)
│   └── [audio.nix](./core/audio.nix)
├── [home](./home)
│   ├── [common](./home/common)
│   │   ├── [default.nix](./home/common/default.nix)
│   │   ├── nixvim
│   │   │   ├── default.nix
│   │   │   └── plugins
│   │   ├── opentabletdriver
│   │   │   └── profiles
│   │   ├── [systemd-services](./home/common/systemd-services)
│   │   │   └── default.nix
│   │   └── [themes](./home/common/themes)
│   │       ├── default.nix
│   │       ├── SerenityOS.nix
│   │       └── template.nix
│   ├── desktop
│   │   ├── [common](./home/desktop/common)
│   │   │   └── [default.nix](./home/desktop/common/default.nix)
│   │   ├── hypr
│   │   │   ├── [default.nix](./home/desktop/hypr/default.nix)
│   │   │   ├── [hyprland.nix](./home/desktop/hypr/hyprland.nix)
│   │   │   └── [scripts](./home/desktop/hypr/scripts)
│   │   └── sway
│   │       ├── [default.nix](./home/desktop/sway/default.nix)
│   │       └── [sway.nix](./home/desktop/sway/sway.nix)
│   └── [users](./home/users)
│       ├── default.nix
│       └── u-serenity.nix
├── [hosts](./hosts)
│   ├── hades]
│   │   ├── [default.nix](./hosts/hades/default.nix)
│   │   ├── [hardware-configuration.nix](./hosts/hades/hardware-configuration.nix)
│   │   └── [modules](./hosts/hades/modules)
│   └── [persephone](./hosts/persephone)
│       ├── [default.nix](./hosts/persephone/default.nix)
│       ├── [hardware-configuration.nix](./hosts/persephone/hardware-configuration.nix)
│       └── [modules](./hosts/persephone/modules)
└── resources
    ├── [icons](./resources/icons)
    └── [wallpapers](./resources/wallpapers)
