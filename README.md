To Do:
---

> uh so, yeah, wei dunno, wei couldn't even fiure out how to make flakes and home manager and w/e else work
> with GNOME, so instead wei are jumping into a new WM/DE because that will definitely be "easier",, right? 
> - [Hyprland](https://hyprland.org/)

---


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
