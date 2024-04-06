To Do:

> in order of priority


 - [ ] learn home manager (seriously wtf ???)
 - [ ] become more learn-ed in the ways of nix-fu

  - [X] build hyprland **branch**
   - [ ] get it working, stable, etc
   - [ ] build minimal fallback gnome branch
     - [ ] get flake to actually build
     
 - [ ] per host hardware configurations
   - [ ] Hades
   - [X] Proserpina
   
 - [ ] (+ per host theming)

---

Cursory flake structure [Heavily WIP]


```

[CURRENT]

.
├── flake
├── core
│   ├── configuration
│   ├── packages
│   └── users
├── home
│   ├── home
│   └── hyprland
├── hosts
│   └── proserpina
│		└── configuration
└── resources

```
---
```

[PLANNED]

.
├── flake
├── core
│   ├── core-config
│   ├── packages
│   ├── services
│   └── users
├── home
│   ├── home-config
│   ├── packages
│   ├── firefox
│   ├── gaming
│   ├── git
│   ├── fish
│   ├── micro
│   ├── kitty
│   ├── starship
│   └── hyprland
│		├── hypr-misc
│		├── waybar
│		├── dunst
│		└── wofi
└── hosts
    ├── hades
	│   ├── configuration
	│   └── resources
    └── proserpina
	    ├── configuration
		└── resources

```
