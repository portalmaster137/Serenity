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

WIP Flake structure

```
.
├── README.md
├── core
│   ├── configuration
│   ├── packages
│   └── users
├── flake.lock
├── flake.nix
├── home
│   ├── home.nix
│   ├── hyprland
│   │   ├── dunst
│   │   ├── hyprcursor
│   │   ├── hypridle
│   │   ├── hyprland
│   │   ├── hyprlock
│   │   ├── hyprpaper
│   │   ├── waybar
│   │   ├── wlogout
│   │   └── wofi
│   ├── git
│   ├── fish
│   ├── kitty
│   └── theme
│       ├── SerenityOS
│       ├── config
│       └── resources
│           ├── icons
│           └── wallpapers
└── hosts
    └── proserpina
        ├── configuration
        ├── disko-config
        ├── hardware-configuration
        └── network-configuration

```
