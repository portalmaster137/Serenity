Hey there,
feel free to do as you wish with these configs :)

Heavily WIP, and at this point, still mostly stolen code.

This is muir "in-use" Hyprland compositor branch.
For a stripped out "core" config, 
[click here](https://codeberg.org/serenity-F/nixdots/src/branch/core)

To Do:

> in order of priority

 - [ ] learn home manager (seriously wtf ???)
 
 - [ ] become more learn-ed in the ways of nix-fu

 - [ ] get flake to actually build
   - [ ] repair #hyprland-merge after merge with updated #core
    - [ ] merge into #hyprland and rebuild-switch

 - [X] build "core" branch for all variant flakes to build upon
   - [ ] finish separating home/ and core/ packages & programs
   - [ ] change one 'branch' & respective git branch at a time

 - [X] merge updated aspects of core branch into hyprland branch

 - [ ] hybrid shared/multi-user home-manager configuration
   - [ ] functional

 - [ ] build minimal fallback gnome branch
     
 - [ ] per host hardware configurations
   - [ ] Hades
     - [ ] adjust Hades' configs
   - [X] Proserpina 

 - [ ] per host themes
   - [ ] Hades
   - [ ] Proserpina

---

Cursory flake Structure

```
.
├── core
│   ├── configuration
│   ├── display
│   └── packages
├── flake
├── home
│   ├── scripts
│   │   ├── anotherhadi
│   │   └── zethra
│   ├── hyprland
│   └── users
└── hosts
    ├── hades
    └── proserpina
```
---

Full flake structure

```
.
├── core
│   ├── configuration.nix
│   ├── display.nix
│   └── packages.nix
├── flake.lock
├── flake.nix
├── home
│   ├── fish.nix
│   ├── git.nix
│   ├── home.nix
│   ├── kitty.nix
│   ├── lazygit.nix
│   ├── neofetch.nix
│   ├── scripts
│   │   ├── anotherhadi
│   │   └── zethra
│   ├── hyprland
│   │   ├── dunst.nix
│   │   ├── hyprcursor.nix
│   │   ├── hypridle.nix
│   │   ├── hyprland.nix
│   │   ├── hyprlock.nix
│   │   ├── hyprpaper.nix
│   │   ├── theme
│   │   │   ├── SerenityOS.nix
│   │   │   ├── config
│   │   │   ├── default.nix
│   │   │   └── resources
│   │   │       ├── icons
│   │   │       └── wallpapers
│   │   ├── waybar.nix
│   │   ├── wlogout.nix
│   │   └── wofi.nix
│   └── users
│       ├── default.nix
│       ├── u-coffee.nix
│       ├── u-serenity.nix
│       ├── u-template.nix
│       └── users.nix
└── hosts
    ├── hades
    │   ├── configuration.nix
    │   ├── disko-config.nix
    │   ├── hardware-configuration.nix
    │   └── network-configuration.nix
    └── proserpina
        ├── configuration.nix
        ├── disko-config.nix
        ├── hardware-configuration.nix
        └── network-configuration.nix
```
