Hey there,
feel free to do as you wish with these configs :)

Heavily WIP, and at this point, still mostly stolen code.


This is the "core" branch, for building on top of,
for muir actually "in-use" branch, 
[click here](https://codeberg.org/serenity-F/nixdots/src/branch/hyprland)

To Do:

> in order of priority

 - [ ] learn home manager (seriously wtf ???)
 
 - [ ] become more learn-ed in the ways of nix-fu

 - [ ] get flake to actually build
   - [ ] keep branches synced

 - [X] build "core" branch for all variant flakes to build upon
   - [ ] finish separating home/ and core/ packages & programs

 - [ ] hybrid shared/multi-user home-manager configuration
   - [ ] functional?

 - [ ] build minimal fallback gnome branch
     
 - [ ] per host hardware configurations
   - [ ] Hades
   - [X] Proserpina 

 - [ ] per host themes
   - [ ] Hades
   - [ ] Proserpina

---

Cursory flake structure

```
.
├── core
│   ├── configuration
│   └── packages
├── flake
├── home
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
│   └── packages.nix
├── flake.lock
├── flake.nix
├── home
│   ├── git.nix
│   ├── home.nix
│   └── users
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
