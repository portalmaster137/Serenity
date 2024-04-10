Hey there, feel free to do as you wish with these configs.<br>
Heavily WIP, and at this point, still mostly stolen code.<br>
This is the "core" branch, everything is built on top of.
For the actively used branch, click
[here](https://codeberg.org/serenity-F/nixdots/src/branch/hyprland).
<br>
<br>
Want a quick rundown of what, and why this is?
<br>
- The what:
  - Shared declarative configuration for system, applications,
 configs, and themes, shared across multiple machines and users.
  - The core of the flake is separated into its own branch, to keep
 it kinda clean while wei mess around with other desktops and stuff.
  - Packages are separated into system-level and user-level, with
 some otherwise system stuff in user-level for ease of config.
  - Some further modularisation of packages on a user by user basis. 
<br>
- The why:
  - Wei are a plural system so the ability to have discete
  accounts and configs while still retaining a complete
  and largely preconfigured desktop environment is *nice*.
  - Also wei break muir install a lot.
  - Also wei're sick of losing muir dotfiles, and reconfiguring
  everything all the dam time, and wei're sick of distrohopping,
  anduhgekwfuhwlf2q9a...

---

Checklist:

 - [X] evaluates successfully
 
 - [ ] #core changes synced across other branches
 
 - [X] hybrid multi-user home-manager configuration
   - [ ] functional (needs testing)
     
 - [ ] per host hardware configurations
   - [ ] Hades (waiting on new boot drive)
   - [X] Proserpina 

 - [ ] find a way to install Arcticons "the nix way"
   
---

All branches in this are supersets of this one, but much more subject
to change. <br>
Feel free to clone the repo and use `tree` to explore other
branches.<br>
Here is the core structure that is common to all branches:

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
