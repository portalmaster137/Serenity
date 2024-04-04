### Flake Structure

---

```
.
├── README.md
├── TODO.md
├── STRUCTURE.md
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

---
