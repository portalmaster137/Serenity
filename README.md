Hey there,
if you're not muis or one of muir headmates,
feel free to do as you wish with these configs :)

if you&'re a headmate, read [this](.guide/README.md)

To Do:

> in order of priority

 - [ ] learn home manager (seriously wtf ???)
 
 - [ ] become more learn-ed in the ways of nix-fu

 - [ ] get flake to actually build
   - [ ] repair config after merge with updated #core branch

 - [X] build "core" branch for all variant flakes to build upon
   - [ ] finish separating home/ and core/ packages & programs
   - [ ] change one 'branch' & respective git branch at a time
 - [ ] merge updated aspects of core branch into hyprland branch

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

WIP Flake Structure

```
.
├── core
│   ├── configuration
│   └── packages
├── flake
├── home
│   ├── git
│   ├── fish
│   ├── kitty
│   ├── hyprland
│   ├── theme
│   │   └── resources
│   └── users
└── hosts
	├── hades
    └── proserpina
```
---
```
.
├── core
│   ├── configuration.nix
│   └── packages.nix
├── flake.lock
├── flake.nix
├── home
│   ├── home.nix
│   ├── git.nix
│   ├── fish.nix
│   ├── kitty.nix
│   ├── hyprland
│   │   ├── hyprcursor.nix
│   │   ├── hyprpaper.nix
│   │   ├── hypridle.nix
│   │   ├── hyprland.nix
│   │   ├── hyprlock.nix
│   │   ├── wlogout.nix
│   │   ├── waybar.nix
│   │   ├── wofi.nix
│   │   └── dunst.nix
│   ├── theme
│   │   ├── SerenityOS.nix
│   │   ├── config
│	│	│	└── template.nix
│   │   └── resources
│   │       ├── icons
│   │       └── wallpapers
│   └── users
│       ├── users.nix
│       ├── u-template.nix
│       ├── u-coffee.nix
│       └── u-serenity.nix
└── hosts
	├── hades
    │   ├─ configuration.nix
    │   ├─ disko-config.nix
    │   ├── hardware-configuration.nix
    │   └── network-configuration.nix
    └── proserpina
        ├── configuration.nix
        ├── disko-config.nix
        ├── hardware-configuration.nix
        └── network-configuration.nix
```
