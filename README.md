uh so, yeah, wei dunno, wei couldn't even fiure out how to make flakes and home manager and w/e else work with GNOME,
so instead wei are jumping into a tiling WM because that will definitely be "easier" ... right ? ... ? 

##### Structure:

```
├── flake.nix
├── hosts
│   └── proserpina
│       ├── configuration.nix
│       ├── disko-config.nix
│       ├── hardware-configuration.nix
│       └── network-configuration.nix
└── modules
    ├── core
    │   ├── configuration.nix
    │   ├── display.nix
    │   ├── home.nix
    │   ├── packages
    │   │   ├── default.nix
    │   │   └── packages.nix
    │   └── services.nix
    └── home
        ├── default.nix
        ├── direnv
        ├── fish
        ├── git
        │   └── default.nix
        ├── hyprland
        │   ├── default.nix
        │   └── environment.nix
        ├── kitty
        │   └── default.nix
        ├── micro
        ├── misc
        │   └── default.nix
        ├── resources
        │   ├── icons
        │   └── wallpapers
        ├── starship
        ├── stylix
        └── waybar
```


[Hyprland](https://hyprland.org/)
