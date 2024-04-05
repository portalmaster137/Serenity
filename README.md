To Do:
---

> uh so, yeah, wei dunno, wei couldn't even fiure out how to make flakes and home manager and w/e else work
> with GNOME, so instead wei are jumping into a new WM/DE because that will definitely be "easier",, right? 
> - [Hyprland](https://hyprland.org/)

---


> in order of priority


 - [X] build ultraminimal general config **branch**
   - [ ] build hyprland **branch**, following above structure
   - [ ] build minimal fallback gnome **branch**, following main structure
   - [ ] create new branch, merge, etc, make default branch if:
     - [X] get flake to actually build
     
 - [ ] per host hardware configurations
   - [ ] Hades
   - [X] Proserpina
   
---

Cursory flake structure [Heavily WIP]

---

```
.
├── flake.nix
├── hosts
│   ├── hades [MISSING]
│   └── proserpina
└── modules
    └── core
        ├── audio
        ├── default
        ├── display
        ├── home
        ├── packages
        └── services

```

---
