To Do:

> in order of priority

 - [X] get flake to actually build

 - [X] build "core" branch for all variant flakes to build upon
 - [ ] finish separating home/ and core/ packages & programs
 - [ ] merge updated aspects of core branch into hyprland branch

 - [ ] hybrid shared/multi-user home-manager configuration
   - [ ] functional
     
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
│   ├── git.nix
│   ├── home.nix
│   └── users
│       ├── -coffee.nix
│       ├── -serenity.nix
│       ├── -template.nix
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
