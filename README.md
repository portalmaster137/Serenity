To Do:
> in order of priority


 - [X] build "core" branch for all variant flakes to build upon
     - [X] get flake to actually build
     
 - [ ] per host hardware configurations
   - [ ] Hades
   - [X] Proserpina
   
---

WIP Flake Structure

```
.
├── README
├── core
│   ├── configuration
│   ├── packages
│   └── users
├── flake.lock
├── flake.nix
└── hosts
    └── proserpina
        ├── configuration
        ├── disko-config
        ├── hardware-configuration
        └── network-configuration
```
