Hey there,
feel free to do as you wish with these configs. :)


Heavily WIP, and at this point, still mostly stolen code.

This is the "core" branch, for building on top of,
for the actively used branch,
[click here.](https://codeberg.org/serenity-F/nixdots/src/branch/hyprland)

> Checklist:

 - [X] flake builds
 - [ ] home/ and core/ packages & programs fully separated
 - [ ] #core changes synced across other branches
 
 - [X] hybrid multi-user home-manager configuration
   - [ ] functional
     
 - [ ] per host hardware configurations
   - [ ] Hades
   - [X] Proserpina 
   
---

All branches in this are supersets of this one,
but much more subject to change. Feel free to
clone the repo and use `tree` to explore other
branches; here is the core structure:

```
.
├── core
│   ├── configuration.nix
│   └── packages.nix
├── flake.nix
├── home
│   ├── git.nix
│   ├── home.nix
│   └── users
└── hosts
    ├── hades
    │   ├── configuration.nix
    │   ├── hardware-configuration.nix
    │   ├── network-configuration.nix
	│	└── disko-config.nix
    └── proserpina
        ├── configuration.nix
        ├── hardware-configuration.nix
        ├── network-configuration.nix
		└── disko-config.nix

```
