Hey there,
feel free to do as you wish with these configs :)


Heavily WIP, and at this point, still mostly stolen code.

This is muir "in-use" Hyprland compositor branch.
For a stripped out "core" config, 
[click here](https://codeberg.org/serenity-F/nixdots/src/branch/core)

Checklist:

> in order of priority

 - [X] flake builds
 - [ ] home/ and core/ packages & programs fully separated
 - [ ] #core changes synced across other branches
 
 - [X] hybrid multi-user home-manager configuration
   - [ ] functional
     
 - [ ] per host hardware configurations
   - [ ] Hades
   - [X] Proserpina 
   
---

Here is the core flake structure, all branches in this are
supersets of this, but very much subject to change.
Feel free to clone the repo and use `tree` to explore the
structure of other branches.

```
.
├── core
│   ├── configuration.nix
│   ├── packages.nix
│   └── misc.nix
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
